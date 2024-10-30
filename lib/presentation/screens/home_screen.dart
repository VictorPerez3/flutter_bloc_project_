import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_event.dart';
import '../blocs/home/home_state.dart';
import '../../data/repositories/info_repository_impl.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_snackbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        repository: InfoRepositoryImpl(),
      )..add(FetchAllInfoEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            CustomSnackBar.show(context, state.message);
            context.go('/');
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Scaffold(
              backgroundColor: Color(0xFFEFEAEA),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is HomeLoaded) {
            return Scaffold(
              backgroundColor: const Color(0xFFEFEAEA),
              appBar: AppBar(
                backgroundColor: const Color(0xFFEFEAEA),
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 6.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC8C8C8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, color: Colors.black),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0, top: 6.0),
                    child: IconButton(
                      icon: const Icon(Icons.logout, color: Colors.black),
                      onPressed: () {
                        context.go('/');
                      },
                    ),
                  )
                ],
              ),
              body: _infoList(state),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _infoList(HomeLoaded state) {
    return ListView.builder(
      itemCount: state.allInfo.length,
      itemBuilder: (context, index) {
        final infoCard = state.allInfo[index];
        return GestureDetector(
          onTap: () {
            context.go('/details/$index', extra: infoCard);
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    infoCard.imageLarge,
                    width: double.infinity,
                    height: 200,
                    alignment: Alignment.centerRight,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 50),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        infoCard.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  infoCard.shortDescription,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
