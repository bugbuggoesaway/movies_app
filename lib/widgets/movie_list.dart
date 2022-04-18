import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/models/pagination.dart';
import 'package:myapp/service/webservice.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MovieListState();
}

class MovieListState extends State<MovieList> {
  static const int _size = 10;

  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('豆瓣电影 Top 250'),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, Movie>.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Movie>(
            animateTransitions: true,
            itemBuilder: _buildMovieItem,
            noMoreItemsIndicatorBuilder: (context) =>
                const Center(child: Text('---我是有底线的---')),
          ),
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }

  Widget _buildMovieItem(BuildContext context, Movie movie, int index) {
    return ListTile(
      title: Text(movie.chineseName),
      subtitle: Text(movie.summary),
      leading: Image.network(movie.coverUrl),
      trailing: Wrap(
        spacing: 5,
        children: [
          SimpleStarRating(
            allowHalfRating: true,
            starCount: 5,
            rating: movie.rating / 20,
            isReadOnly: true,
            // spacing: 10,
            size: 15,
          ),
          Text('${movie.rating / 10}'),
        ],
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      WebService().load(Pagination.list(pageKey, _size)).then((pagination) {
        if (pagination.hasNext) {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(pagination.data, nextPageKey);
        } else {
          _pagingController.appendLastPage(pagination.data);
        }
      });
    } catch (error) {
      _pagingController.error(error);
    }
    return;
  }
}
