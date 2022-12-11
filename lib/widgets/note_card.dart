// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:safenotes/data/preference_and_config.dart';
import 'package:safenotes/models/safenote.dart';
import 'package:safenotes/utils/notes_color.dart';
import 'package:safenotes/utils/text_direction_util.dart';
import 'package:safenotes/utils/string_utils.dart';
import 'package:safenotes/utils/time_utils.dart';

class NoteCardWidget extends StatelessWidget {
  final SafeNote note;
  final int index;

  NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Pick colors from the accent colors based on index
    final color = NotesColor.getNoteColor(notIndex: index);
    final fontColor = getFontColorForBackground(color);

    DateTime now = DateTime.now();
    DateTime todayDate = DateTime(now.year, now.month, now.day);
    DateTime noteDate = DateTime(
        note.createdTime.year, note.createdTime.month, note.createdTime.day);
    String time = (todayDate == noteDate)
        ? humanTime(
            time: note.createdTime,
            localeString: context.locale.toString(),
          )
        : DateFormat.yMMMd().format(note.createdTime);

    return Card(
      shadowColor: PreferencesStorage.isThemeDark ? Colors.white : Colors.black,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //crossAxisAlignment: CrossAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AutoSizeText(
              sanitize(note.title),
              textDirection: getTextDirecton(note.title),
              style: TextStyle(
                color: fontColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 20,
              maxLines: 2,
              overflow: TextOverflow.clip,
              //overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              time,
              textDirection: getTextDirecton(time),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: fontColor,
              ),
            ),
            SizedBox(height: 6),
            AutoSizeText(
              sanitize(note.description),
              textDirection: getTextDirecton(note.description),
              style: TextStyle(
                color: fontColor,
                fontSize: 16,
                //fontWeight: FontWeight.bold,
              ),
              minFontSize: 16,
              maxLines: getMaxLine(index), //3,
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
    );
  }

  int getMaxLine(int index) {
    switch (index % 4) {
      case 0:
        return 2;
      case 1:
        return 3;
      case 2:
        return 4;
      case 3:
        return 3;
      default:
        return 3;
    }
  }
}
