import '../movie_app/movie.dart';
import 'package:flutter/material.dart';



class MovieListView extends StatelessWidget {

  final List<Movie> movieList = Movie.getMovies();

  final List movies = [
    "Titanic",
    "Blade Runner",
    "Rambo",
    "The Avengers",
    "Avatar",
    "I Am Legend",
    "300",
    "The Wolf Of Wall Street",
    "Interstellar",
    "Game of Thrones",
    "Vikings"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index){
            return Stack(
                children:[
                  movieCard(movieList[index], context),
                  Positioned(
                      top: 10.0,
                      child: movieImage(movieList[index].images[0])),

                ]);
            /*  return Card(
          elevation: 4.5,
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(movieList[index].images[0]),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(13.9)
                ),
                child: Text("H"),
              ),
            ),
            trailing: Text("..."),
            title: Text(movieList[index].title),
            subtitle: Text("${movieList[index].title}"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieListViewDetails(movieName: movieList.elementAt(index).title,
              movie: movieList[index],)));
            },
            //onTap: () => debugPrint("Movie name: ${movies.elementAt(index)}"),

          ),
        ); */
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0,
                bottom: 8.0,
                left: 54.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(movie.title, style:
                        TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Colors.white
                        ),),
                      ),
                      Text("Rating: ${movie.imdbRating}/10",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey
                        ),)
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Released: ${movie.released}",style: mainTextStyle(),),
                      Text(movie.runtime,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey
                          )),
                      Text(movie.rated,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey
                          ))
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieListViewDetails(movieName: movie.title,
          movie: movie,)))
      },
    );
  }

  TextStyle mainTextStyle(){
    return TextStyle(
        fontSize: 15.0,
        color: Colors.grey
    );
  }

  Widget movieImage(String imageUrl){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(imageUrl ?? 'http://ia.media-imdb.com/images/M/MV5BMTYwOTEwNjAzMl5BMl5BanBnXkFtZTcwODc5MTUwMw@@._V1_SX300.jpg'),
              fit: BoxFit.cover
          )
      ),
    );
  }

}

class MovieListViewDetails extends StatelessWidget {

  final String movieName;
  final Movie movie;

  const MovieListViewDetails({super.key, required this.movieName, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          MovieDetailsThumbnail(thumbnail: movie.images[0]),
          MovieDetailsHeaderWithPoster(movie: movie),
          HorizontalLine(),
          MovieDetailsCast(movie: movie),
          HorizontalLine(),
          MovieDetailsExtraPoster(posters: movie.images)
        ],
      ),
      /* body: Center(
        child: Container(
          child: ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Go back ${this.movie.director}")),
        ),
      ),*/
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbnail({super.key, required this.thumbnail});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 170,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(thumbnail),
                    fit: BoxFit.cover
                ),

              ),
            ),
            Icon(Icons.play_circle_outline, size: 100,
              color: Colors.white,)
          ],
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
          ),
          height: 80,
        )
      ],
    );
  }
}
class MovieDetailsHeaderWithPoster extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeaderWithPoster({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          MoviePoster(poster: movie.images[0].toString()),
          SizedBox(width: 16,),
          Expanded(
              child: MovieDetailsHeader(movie: movie))
        ],
      ),
    );
  }
}




class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster({super.key, required this.poster});
  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width/4,
          height: 160,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(poster),
                  fit: BoxFit.cover)
          ),
        ),
      ) ,
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeader({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${movie.year} . ${movie.genre}".toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.cyan
          ),),
        Text(movie.title, style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 32,
        ),),
        Text.rich(TextSpan(style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),children: [
          TextSpan(
              text: movie.plot
          ),
          TextSpan(
              text: "More...",
              style: TextStyle(
                  color: Colors.indigoAccent
              )
          )
        ]
        ))
      ],
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final Movie movie;

  const MovieDetailsCast({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          MovieField(field:"Cast", value: movie.actors),
          MovieField(field: "Directors", value: movie.director),
          MovieField(field: "Awards", value: movie.Awards)
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const MovieField({super.key, required this.field, required this.value});


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$field :", style: TextStyle(
            color: Colors.black38,
            fontSize: 12,
            fontWeight: FontWeight.w800
        ),),
        Expanded(
          child: Text(value, style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w300
          ),),
        )
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12.0),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieDetailsExtraPoster extends StatelessWidget {
  final List posters;

  const MovieDetailsExtraPoster({super.key, required this.posters});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text("Movie posters".toUpperCase(),
            style: TextStyle(
                fontSize: 14,
                color: Colors.black26
            ),),
        ),
        Container(
            height: 170,
            padding: EdgeInsets.symmetric(vertical: 16),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 8,),
                itemCount: posters.length,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)) ,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 160,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(posters[index]),
                            fit: BoxFit.cover)
                    ),
                  ),
                )
            )
        )

      ],
    );
  }
}