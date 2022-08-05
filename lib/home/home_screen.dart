import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tests/home/cubit/home_cubit.dart';
import 'package:flutter_tests/repositories/cat_fact_repository.dart';

class HomeScreen extends StatelessWidget {
  final CatfactRepository repository;

  const HomeScreen({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(repository),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(title: const Text('Flutter tests')),
              floatingActionButton: state is HomeLoading
                  ? const SizedBox()
                  : FloatingActionButton(
                      onPressed: (() => context.read<HomeCubit>().loadCatFact()),
                      child: const Icon(Icons.search),
                    ),
              body: Center(
                  child: state is HomeLoading
                      ? const CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (state is HomeMainState)
                                Text(
                                  state.catFact?.fact ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              if (state is HomeError) const Text('Something goes wrong', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        )));
        },
      ),
    );
  }
}
