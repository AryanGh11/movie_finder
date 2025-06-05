import 'package:flutter/material.dart';
import 'package:movie_finder/widgets/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_finder/utils/error_handler.dart';

class ProfilePageEditDisplayNameDialog extends StatefulWidget {
  final User fUser;
  final void Function(User user) onFUserUpdated;

  const ProfilePageEditDisplayNameDialog({
    super.key,
    required this.fUser,
    required this.onFUserUpdated,
  });

  @override
  State<ProfilePageEditDisplayNameDialog> createState() =>
      _ProfilePageEditDisplayNameDialogState();
}

class _ProfilePageEditDisplayNameDialogState
    extends State<ProfilePageEditDisplayNameDialog> {
  final TextEditingController _displayNameController = TextEditingController();
  bool _isButtonDisabled = false;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    if (_displayNameController.text == widget.fUser.displayName) {
      setState(() {
        _isButtonDisabled = true;
      });
    }
  }

  Future<void> _changeDisplayName() async {
    if (_displayNameController.text.isEmpty) return;

    setState(() {
      _isUpdating = true;
    });

    try {
      await widget.fUser.updateDisplayName(_displayNameController.text);
      await widget.fUser.reload();
      final User? updatedUser = FirebaseAuth.instance.currentUser;
      widget.onFUserUpdated(updatedUser!);
    } catch (e) {
      ErrorHandler.handle(e);
    } finally {
      setState(() {
        _isUpdating = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "Display Name",
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          spacing: 10,
          children: [
            CustomTextField(
              controller: _displayNameController,
              variant: CustomTextFieldVariant.outlined,
              hintText: widget.fUser.displayName,
              onChanged: (value) {
                if (value.trim().isEmpty) {
                  setState(() {
                    _isButtonDisabled = true;
                  });
                } else {
                  setState(() {
                    _isButtonDisabled = false;
                  });
                }
              },
            ),
            CustomElevatedButton(
              text: "Change",
              onPressed: _isButtonDisabled ? null : _changeDisplayName,
              loading: _isUpdating,
            ),
          ],
        ),
      ),
    );
  }
}
