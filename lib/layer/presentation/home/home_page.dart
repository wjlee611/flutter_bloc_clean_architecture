import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/sizes.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/bloc/home_state.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/widget/article_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            key: Key('signout-button'),
            onPressed: () {
              AuthBlocSingleton.instance.add(AuthSignoutEvent());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverList.separated(
                  itemBuilder: (context, index) => ArticleCard(
                    article: state.articles[index],
                    buildCallback: () {
                      if (index + 1 == state.articles.length) {
                        context
                            .read<HomeBloc>()
                            .add(HomeLoadMoreArticlesEvent());
                      }
                    },
                  ),
                  separatorBuilder: (context, index) => Container(
                    height: Sizes.size1,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                  ),
                  itemCount: state.articles.length,
                ),
                SliverToBoxAdapter(
                  child: Builder(
                    builder: (context) {
                      if (state.status == ELoadingStatus.error) {
                        return Column(
                          children: [
                            Text(state.message ?? ''),
                            ElevatedButton(
                              onPressed: () {
                                context.read<HomeBloc>().add(
                                    HomeLoadMoreArticlesEvent(force: true));
                              },
                              child: Text('Retry'),
                            ),
                          ],
                        );
                      }
                      if (state.status != ELoadingStatus.done) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(Sizes.size16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      return SizedBox();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
