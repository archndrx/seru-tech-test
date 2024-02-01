import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:seru_tech_test/shared/theme.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.title,
    this.obscureText = false,
    this.controller,
    this.keyType,
    this.minLines,
  });

  final String title;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyType;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackTextStyle.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          minLines: minLines,
          maxLines: null,
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyType,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: greyTextStyle.copyWith(
              fontSize: 14,
            ),
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropDownSearchForm extends StatelessWidget {
  final String title;
  final List<String> items;
  final String selectedItem;
  final void Function(String?) onChanged;

  const CustomDropDownSearchForm({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackTextStyle.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        DropdownSearch<String>(
          items: items,
          onChanged: onChanged,
          selectedItem: selectedItem,
          popupProps: const PopupProps.menu(
            constraints: BoxConstraints(maxHeight: 200),
            showSelectedItems: true,
            listViewProps: ListViewProps(),
            searchFieldProps: TextFieldProps(),
            showSearchBox: true,
            menuProps: MenuProps(),
            searchDelay: Duration(seconds: 0),
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            textAlignVertical: TextAlignVertical.center,
            dropdownSearchDecoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
