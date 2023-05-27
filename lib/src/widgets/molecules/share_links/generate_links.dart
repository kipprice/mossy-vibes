class ShareLinks {
  Uri? facebook;
  Uri? twitter;
  Uri? linkedIn;
  Uri? email;
  Uri? mossyEmail;
  Uri? mossyInstagram;
  Uri? donate;
}

ShareLinks generateShareLinks() {
  const url = 'https://mossyvibes.com';
  const title = 'Meditation for busy people';
  const body =
      "I've been using Mossy Vibes to fit meditation into my day, and I think you might like it too!";

  ShareLinks links = ShareLinks()
    ..facebook = Uri.parse('https://www.facebook.com/sharer/sharer.php?u=$url')
    ..twitter =
        Uri.parse('https://twitter.com/intent/tweet?url=$url&text=$body')
    ..email = Uri.parse('mailto:?subject=$title&body=$body $url')
    ..linkedIn = Uri.parse(
        'https://www.linkedin.com/sharing/share-offsite/?url=$url/&summary=$body')
    ..mossyEmail = Uri.parse('mailto:hello@mossyvibes.com')
    ..mossyInstagram = Uri.parse('https://instagram.com/mossy_vibes_app')
    ..donate = Uri.parse('https://buymeacoffee.com/mossyvibes');

  return links;
}
