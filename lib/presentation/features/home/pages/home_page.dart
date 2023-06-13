import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_demo/core/extensions/dartz.dart';
import 'package:graphql_demo/injection.dart';
import 'package:graphql_demo/presentation/features/home/bloc/home_cubit.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Rick And Morty"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (p, s) => p.processing != s.processing,
              builder: (context, state) {
                if (state.processing) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.characters.isNone()) {
                  return const Center(child: Text("No Data"));
                } else if (state.characters.isSome() && state.characters.asSome.isLeft()) {
                  /// errors
                  return Center(child: Text(state.characters.asSome.asLeft));
                }

                final characters = state.characters.asSome.asRight;
                if (characters.isEmpty) {
                  return const Center(child: Text("No Data"));
                } else {
                  return ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      final character = characters[index];
                      return ListTile(
                        key: Key(character.id),
                        leading: Image.network(character.image),
                        title: Text(character.name),
                      );
                    },
                  );
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
