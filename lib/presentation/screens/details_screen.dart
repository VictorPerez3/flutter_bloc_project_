import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/info.dart';
import '../blocs/details/details_bloc.dart';
import '../blocs/details/details_event.dart';
import '../blocs/details/details_state.dart';
import '../../data/repositories/info_repository_impl.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_snackbar.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsBloc(
        repository: InfoRepositoryImpl(),
      )..add(FetchInfoByIdEvent(id)),
      child: BlocConsumer<DetailsBloc, DetailsState>(
        listener: (context, state) {
          if (state is DetailsError) {
            CustomSnackBar.show(context, state.message);
            context.go('/');
          }
        },
        builder: (context, state) {
          if (state is DetailsLoading) {
            return const Scaffold(
              backgroundColor: Color(0xFFEFEAEA),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is DetailsLoaded) {
            return _detailsContent(state.info, context);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _detailsContent(Info infoCard, BuildContext context) {
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
              icon: const Icon(
                Icons.close,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                context.go('/home');
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  infoCard.name,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  infoCard.imageSmall,
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.fill,
                  alignment: Alignment.bottomRight,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      width: double.infinity,
                      height: 400,
                      color: Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 400,
                      color: Colors.grey[300],
                      child: const Center(
                          child: Icon(Icons.broken_image, size: 50)),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Text(
                infoCard.description,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
