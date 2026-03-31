import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sahab/core/helpers/extensions.dart';

class HtmlService {
  /// Strip HTML tags from string and return plain text
  static String stripHtmlTags(String htmlString) {
    // First remove product links
    String cleaned = _removeMoreProductsLinks(htmlString);
    // Then remove all HTML tags
    final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return cleaned.replaceAll(exp, ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Remove "More products" links from HTML content
  static String _removeMoreProductsLinks(String htmlString) {
    // Remove Arabic "المزيد من المنتجات" links
    String cleaned = htmlString.replaceAll(
      RegExp(
        r'<a[^>]*>[\s\S]*?المزيد من المنتجات[\s\S]*?</a>',
        multiLine: true,
        caseSensitive: false,
      ),
      '',
    );

    // Remove English "See more products" links
    cleaned = cleaned.replaceAll(
      RegExp(
        r'<a[^>]*>[\s\S]*?See more products[\s\S]*?</a>',
        multiLine: true,
        caseSensitive: false,
      ),
      '',
    );

    // Remove any remaining links that contain product-category in URL
    cleaned = cleaned.replaceAll(
      RegExp(
        r'<a[^>]*product-category[^>]*>.*?</a>',
        multiLine: true,
        caseSensitive: false,
        dotAll: true,
      ),
      '',
    );

    return cleaned.trim();
  }

  /// Get HTML widget with custom styling for the app
  static Widget getHtmlWidget(BuildContext context, String htmlData) {
    // Remove "More products" links before displaying
    String cleanedHtml = _removeMoreProductsLinks(htmlData);
    return Html(data: cleanedHtml, style: _getHtmlStyles(context));
  }

  /// Get HTML styles configuration
  static Map<String, Style> _getHtmlStyles(BuildContext context) {
    final onSurface = context.onSurfaceColor;
    final labelColor = context.labelColor;
    final primary = context.primaryColor;

    return {
      "body": Style(
        margin: Margins.zero,
        padding: HtmlPaddings.zero,
        fontSize: FontSize(14),
        color: onSurface,
        fontFamily: 'Tajawal',
      ),
      "h1": Style(
        fontSize: FontSize(18),
        fontWeight: FontWeight.bold,
        color: onSurface,
        margin: Margins.only(bottom: 8, top: 16),
      ),
      "h2": Style(
        fontSize: FontSize(16),
        fontWeight: FontWeight.bold,
        color: onSurface,
        margin: Margins.only(bottom: 6, top: 12),
      ),
      "h3": Style(
        fontSize: FontSize(14),
        fontWeight: FontWeight.bold,
        color: onSurface,
        margin: Margins.only(bottom: 4, top: 8),
      ),
      "h4": Style(
        fontSize: FontSize(13),
        fontWeight: FontWeight.bold,
        color: onSurface,
        margin: Margins.only(bottom: 4, top: 6),
      ),
      "h5": Style(
        fontSize: FontSize(12),
        fontWeight: FontWeight.bold,
        color: onSurface,
        margin: Margins.only(bottom: 2, top: 4),
      ),
      "h6": Style(
        fontSize: FontSize(11),
        fontWeight: FontWeight.bold,
        color: onSurface,
        margin: Margins.only(bottom: 2, top: 4),
      ),
      "p": Style(
        fontSize: FontSize(14),
        color: labelColor,
        margin: Margins.only(bottom: 8),
        lineHeight: LineHeight(1.4),
      ),
      "ul": Style(margin: Margins.only(bottom: 8, left: 16)),
      "ol": Style(margin: Margins.only(bottom: 8, left: 16)),
      "li": Style(
        fontSize: FontSize(14),
        color: labelColor,
        margin: Margins.only(bottom: 4),
      ),
      "strong": Style(fontWeight: FontWeight.bold),
      "b": Style(fontWeight: FontWeight.bold),
      "em": Style(fontStyle: FontStyle.italic),
      "i": Style(fontStyle: FontStyle.italic),
      "a": Style(
        color: primary,
        textDecoration: TextDecoration.underline,
      ),
      "div": Style(margin: Margins.zero),
      "span": Style(margin: Margins.zero),
      "blockquote": Style(
        margin: Margins.only(left: 16, bottom: 8),
        padding: HtmlPaddings.only(left: 8),
        border: Border(
          left: BorderSide(
            color: onSurface.withValues(alpha: 0.1),
            width: 2,
          ),
        ),
        backgroundColor: onSurface.withValues(alpha: 0.05),
      ),
      "code": Style(
        backgroundColor: onSurface.withValues(alpha: 0.05),
        fontSize: FontSize(12),
        fontFamily: 'monospace',
        padding: HtmlPaddings.symmetric(horizontal: 4, vertical: 2),
      ),
      "pre": Style(
        backgroundColor: onSurface.withValues(alpha: 0.05),
        fontSize: FontSize(12),
        fontFamily: 'monospace',
        padding: HtmlPaddings.all(8),
        margin: Margins.only(bottom: 8),
        whiteSpace: WhiteSpace.pre,
      ),
    };
  }

  /// Get HTML styles with custom font size
  static Map<String, Style> getHtmlStylesWithFontSize(BuildContext context, double fontSize) {
    final styles = _getHtmlStyles(context);

    // Update font sizes proportionally
    styles["body"] = styles["body"]!.copyWith(fontSize: FontSize(fontSize));
    styles["p"] = styles["p"]!.copyWith(fontSize: FontSize(fontSize));
    styles["li"] = styles["li"]!.copyWith(fontSize: FontSize(fontSize));
    styles["h1"] = styles["h1"]!.copyWith(fontSize: FontSize(fontSize + 4));
    styles["h2"] = styles["h2"]!.copyWith(fontSize: FontSize(fontSize + 2));
    styles["h3"] = styles["h3"]!.copyWith(fontSize: FontSize(fontSize));
    styles["h4"] = styles["h4"]!.copyWith(fontSize: FontSize(fontSize - 1));
    styles["h5"] = styles["h5"]!.copyWith(fontSize: FontSize(fontSize - 2));
    styles["h6"] = styles["h6"]!.copyWith(fontSize: FontSize(fontSize - 3));

    return styles;
  }

  /// Get HTML widget with custom font size
  static Widget getHtmlWidgetWithFontSize(BuildContext context, String htmlData, double fontSize) {
    // Remove "More products" links before displaying
    String cleanedHtml = _removeMoreProductsLinks(htmlData);
    return Html(data: cleanedHtml, style: getHtmlStylesWithFontSize(context, fontSize));
  }

  /// Check if string contains HTML tags
  static bool containsHtml(String text) {
    final RegExp htmlRegExp = RegExp(r'<[^>]*>', multiLine: true);
    return htmlRegExp.hasMatch(text);
  }

  /// Clean HTML string by removing dangerous scripts and styles
  static String sanitizeHtml(String htmlString) {
    // Remove script tags and their content
    String cleaned = htmlString.replaceAll(
      RegExp(
        r'<script[^>]*>.*?</script>',
        multiLine: true,
        caseSensitive: false,
        dotAll: true,
      ),
      '',
    );

    // Remove style tags and their content
    cleaned = cleaned.replaceAll(
      RegExp(
        r'<style[^>]*>.*?</style>',
        multiLine: true,
        caseSensitive: false,
        dotAll: true,
      ),
      '',
    );

    // Remove dangerous attributes
    cleaned = cleaned.replaceAll(
      RegExp(r'on\w+\s*=\s*[^>\s]*', caseSensitive: false),
      '',
    );

    return cleaned;
  }

  /// Clean HTML by removing "More products" links
  static String removeProductLinks(String htmlString) {
    return _removeMoreProductsLinks(htmlString);
  }
}
