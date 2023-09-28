import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universitytest/Model/University.dart';
import 'package:universitytest/university_bloc/university_bloc.dart';
import 'package:universitytest/university_bloc/university_event.dart';
import 'package:universitytest/university_bloc/university_state.dart';

class UniversityView extends StatelessWidget {
  const UniversityView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Universities list"),
      ),
      body: buildBody(),
    );
  }

  //TODO нежелательрно возвращать Widget в такой функции, лучше делать отдельный виджет
  // либо все возвращать в месте вызова
  Widget buildBody() {
    return BlocConsumer<UniversityBloc, UniversityState>(
        builder: (context, state) {
          if (state is UniversitiesLoadedState) {
            final model = state.universityModel;
            if (model != null) {
              return universitiesList(model);
            } else {
              return const Center(
                  child: Text("Error has occurred while loading universities"));
            }
          } else if (state is UniversityBlocInitialState) {
            return Container(
              color: Colors.amberAccent,
              child: Center(child: loadButton(context)),
            );
          } else {
            return const Text("SOMETHING WENT WRONG!");
          }
        },
        listener: (context, state) {
          if (state is LoadingState) {
            final text = state.isLoading
                ? "Loading universities"
                : "Universities loaded";
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(text), duration: const Duration(seconds: 1)));
          }
        },
        buildWhen: (previous, current) => current is! LoadingState);
  }

  Widget loadButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        final bloc = context.read<UniversityBloc>();
        bloc.add(DidPressLoad());
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),
      child: const Text("Load Universities"),
    );
  }

  Widget universitiesList(UniversityModel universityModel) {
    return ListView.builder(
        itemCount: universityModel.universities.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            title: Text(universityModel.universities[index].displayableTitle,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            subtitle:
                Text(universityModel.universities[index].displayableSubtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                    )),
            trailing: const Icon(Icons.arrow_forward, color: Colors.black),
            onTap: () {
              final bloc = context.read<UniversityBloc>();
              bloc.add(OpenUrl(
                  url: universityModel.universities[index].webPages[0]));
            },
          );
        });
  }
}
