import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';


void main() => runApp( MaterialApp(
      home: MovieListView(),
    ));

class MovieListView extends StatelessWidget {
  MovieListView({Key? key}) : super(key: key);

  final List<Movie> movieList = Movie.getMovies();

  /*final List movie = [
    "Avengers",
    "Heroes",
    "Peaky Blinders",
    "spiderMan",
    "Originals",
    "lagers",
    "Peaches",
    "spiderwoman",
    "vikings",
    "spiderMan",
    "Originals",
    "lagers",
  ];*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Movies"), backgroundColor: Colors.blueGrey.shade800),
      backgroundColor: Colors.blueGrey.shade800,
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: <Widget>[
              movieCard(movieList[index], context),
              Positioned(
                  top: 10.0, child: movieImage(movieList[index].images[0])),
            ]);
            /*return Card(
                elevation: 5.0,
                color: Colors.white,
                child: ListTile(
                    leading: CircleAvatar(
                      child: Container(
                        width: 350,
                        height: 350,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(movieList[index].images[0]),
                                fit: BoxFit.cover),
                            //color: Colors.black,
                            borderRadius: BorderRadius.circular(13.0)),
                        child: null,
                      ),
                    ),
                    trailing: Text("..."),
                    title: Text(movieList[index].title),
                    subtitle: Text("Avartar"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieListViewDetails(
                                    movieName: movieList.elementAt(index).title,
                                    movie: movieList[index],
                                  )));
                    }

                    //onTap: () => debugPrint("movies name: ${movies.elementAt(index)}"),

                    ));*/
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 50),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(movie.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color: Colors.white,
                              )),
                        ),
                        Text(
                          "Rating: ${movie.imdbRating}/ 10",
                          style: TextStyle(fontSize: 15.0, color: Colors.grey),
                        )
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Released: ${movie.released}",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.grey)),
                        Text(movie.runtime,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.grey)),
                        Text(movie.rated,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.grey)),
                      ])
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieListViewDetails(
                      movieName: movie.title,
                      movie: movie,
                    )))
      },
    );
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage(imageUrl ??
                'https://images-na.ssl-images-amazon.com/images/M/MV5BMjMzMzIzOTU2M15BMl5BanBnXkFtZTgwODMzMTkyODE@._V1_SY1000_SX1500_AL_.jpg'),
            fit: BoxFit.cover),
      ),
    );
  }
}

//new route or new screen
class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MovieListViewDetails(
      {Key? key, required this.movieName, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800,
        title: Text("Movies"),
      ),
      body: ListView(
        children: <Widget>[
          movieDetailsThumbnail(thumbnail: movie.images[0]),
          /*this is where we call all the widget methods designed below*/
          movieDetailsHeaderWithPoster(movie: movie),
          horizontalLine(),
          movieDetailsCast(movie: movie),
          horizontalLine(),
          movieDetailsExtraPosters(posters: movie.images)
        ],

        /*child: Center(
          child: ElevatedButton(
            child: Text("Go Back ${this.movie.director}"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),*/
      ),
    );
  }
}

class movieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;
  const movieDetailsThumbnail({Key? key, required this.thumbnail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 280,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(thumbnail), fit: BoxFit.cover)),
            ),
            Icon(Icons.play_circle_outline, size: 100, color: Colors.white)
          ],
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white10, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          height: 80,
        )
      ],
    );
  }
}

class movieDetailsHeaderWithPoster extends StatelessWidget {
  final Movie movie;
  const movieDetailsHeaderWithPoster({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(children: <Widget>[
        MoviePoster(poster: movie.images[0].toString()),
        SizedBox(
            width:
                20), //this helps us to add space between object that we have control over
        Expanded(child: MovieDetailesdHeader(movie: movie))
      ]),
    );
  }
}

class MovieDetailesdHeader extends StatelessWidget {
  final Movie movie;
  const MovieDetailesdHeader({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${movie.year} . ${movie.genre}".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.cyan),
        ),
        Text(
          movie.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 32,
          ),
        ),
        /*the next text wwe want to insert has a long line and we want it to 
        contain or fit into the small space we have, so we use rich Text that has textspan */
        Text.rich(TextSpan(
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            children: <TextSpan>[
              TextSpan(text: (movie.plots)),
              TextSpan(
                  text: "more...",
                  style: TextStyle(
                    color: Colors.indigoAccent,
                  )),
            ]))
      ],
    );
  }
}

class movieDetailsCast extends StatelessWidget {
  final Movie movie;

  const movieDetailsCast({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          MovieField(field: "cast", value: movie.actors),
          MovieField(field: "directors", value: movie.director),
          MovieField(field: "award", value: movie.awards),
          MovieField(field: "writers", value: movie.writers)
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;
  const MovieField({Key? key, required this.field, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("$field:",
            style: TextStyle(
                color: Colors.black38,
                fontSize: 12,
                fontWeight: FontWeight.w300)),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }
}

class horizontalLine extends StatelessWidget {
  const horizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 12.0,
      ),
      child: Container(
        height: 0.8,
        color: Colors.grey,
      ),
    );
  }
}

class movieDetailsExtraPosters extends StatelessWidget {
  final List<String>
      posters; //here we are passing a property that will contain the list of movies, just the URLs
  const movieDetailsExtraPosters({Key? key, required this.posters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment
          .start, //this makes eveerything to start from the left
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            "More Related movies".toUpperCase(),
            style: TextStyle(fontSize: 14, color: Colors.black26),
          ),
        ),
        Container(
          height: 200,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(
              width: 8,
            ),
            itemCount: posters.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 160,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(posters[index]),
                        fit: BoxFit.cover)),
              ),
            ),
          ), //this will be the length of our posters containing list of url
        )
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;
  const MoviePoster({Key? key, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
          borderRadius: borderRadius,
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(poster), fit: BoxFit.cover)),
          )),
    );
  }
}
