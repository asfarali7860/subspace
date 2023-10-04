import 'package:flutter/material.dart';
import 'package:subspace/minor_screen.dart/fav_model.dart';
import 'package:subspace/provider/fav_provider.dart';
import 'package:subspace/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';

class FavPage extends StatefulWidget {
  final bool internet;
  const FavPage({super.key, required this.internet});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('Favourite'),
          actions: [
            context.watch<Fav>().getFavItems.isEmpty
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      MyAlertDilaog.showMyDialog(
                          context: context,
                          title: 'Clear Wishlist',
                          content: 'Are you sure to clear Wishlist ?',
                          tabNo: () {
                            Navigator.pop(context);
                          },
                          tabYes: () {
                            context.read<Fav>().clearFavlist();
                            Navigator.pop(context);
                          });
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.black,
                    ))
          ],
        ),
        body: context.watch<Fav>().getFavItems.isNotEmpty
            ? FavItems(internet: widget.internet)
            : const EmptyFavlist(),
        );
  }
}

class FavItems extends StatefulWidget {
  final bool internet;
  const FavItems({Key? key, required this.internet}) : super(key: key);

  @override
  State<FavItems> createState() => _FavItemsState();
}

class _FavItemsState extends State<FavItems> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Fav>(
      builder: (context, fav, child) {
        return ListView.builder(
            itemCount: fav.count,
            itemBuilder: (context, index) {
              final blog = fav.getFavItems[index];
              return FavModel(blog: blog, internet: widget.internet);
            });
      },
    );
  }
}

class EmptyFavlist extends StatelessWidget {
  const EmptyFavlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Text(
            'Your Favourite Is Empty !',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
