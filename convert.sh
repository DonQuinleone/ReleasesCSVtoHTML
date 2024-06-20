#!/bin/sh

filepath=$1

outdir="/Users/joshuaquinlan/Desktop/Out"

if [ ! -d $outdir ]; then
  echo "Output directory specified does not exist. Please create it then re-run the script."
  exit 1
fi

if [ ! $filepath ]; then 
  echo "Please supply a filepath to the CSV that you wish to convert"
  exit 1
fi

if [ ! -f $filepath ]; then
  echo "The specified file does not exist.\nPlease supply a valid filepath to the CSV that you wish to covnert."
  exit 1
fi

skip_headers=1
while IFS='|' read -r AlbumTitle AlbumWriter SubOrg AlbumFeatArtists ReleaseDate CatNum AppleURL SpotifyURL YouTubeURL PrestoURL Description Track1 Track1Dur Track1Writer Track2 Track2Dur Track2Writer Track3 Track3Dur Track3Writer RecordingLocation RecordingDate Producer Engineer Performers; do
  if ((skip_headers)); then
    ((skip_headers--))
  else
    outpath=$(echo ${outdir}/${CatNum}.html)
    
    listenbuttons="<p style=\"text-align: left;\">"

    if [ "$AppleURL" ]; then
      listenbuttons="$listenbuttons<a href=\"$AppleURL\" class=\"button-pink\">Apple music <i class=\"fa fa-music\" aria-hidden=\"true\"></i></a>"
    fi

    if [ "$SpotifyURL" ]; then
      spotifypath=$(echo $SpotifyURL | sed -E 's/.*\/(album|track)\///; s/=.*//')
      listenbuttons="$listenbuttons<a href=\"https://open.spotify.com/album/$spotifypath\" target=\"_blank\" rel=\"noopener\" class=\"button-pink\">Spotify <i class=\"fa fa-spotify\" aria-hidden=\"true\"></i></a>"
    fi

    if [ "$YouTubeURL" ]; then
      listenbuttons="$listenbuttons<a href=\"$YouTubeURL\" target=\"_blank\" rel=\"noopener\" class=\"button-pink\">Youtube music <i class=\"fa fa-youtube-play\" aria-hidden=\"true\"></i></a>"
    fi

    tracks="1. $Track1 ($Track1Writer) - $Track1Dur<br/>"

    if [ "$Track2" ]; then
      tracks="${tracks}2. $Track2 ($Track2Writer) - $Track2Dur<br/>"
    fi

    if [ "$Track3" ]; then
      tracks="${tracks}3. $Track3 ($Track3Writer) - $Track3Dur<br/>"
    fi

    listenbuttons="$listenbuttons</p>"

    if [ $Performers ]; then
      formattedperformers="<h2>Performers</h2><p>$Performers</p>"
    else
      formattedperformers=""
    fi

    cat <<EOF > $outpath
<table border="1" style="border: 1px #EBEBEB; width: 100.02%;">
<tbody>
<tr>
<td style="background-color: #ebebeb;"><img src="/GetImage.aspx?IDMF=6267e45c-4b32-4667-808a-196a7fbfa87d&amp;w=500&amp;h=500&amp;src=mc" alt="" title="" class="mediaImage"></td>
<td style="background-color: #ebebeb;">
<h3><strong>$AlbumTitle</strong></h3>
$AlbumWriter<br><br><strong>$SubOrg</strong><br>$AlbumFeatArtists<br><br/>Released $ReleaseDate<br><strong>$CatNum</strong></td>
</tr>
</tbody>
</table>
<hr>
<p class="tinymcewrapper-remove">$Description</p>
<h2>Listen now</h2>
<p><iframe width="100%" height="152" style="border-radius: 12px;" src="https://open.spotify.com/embed/album/$spotifypath?utm_source=generator" frameborder="0" allowfullscreen="allowfullscreen" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe></p>
$listenbuttons
<p></p>
<h2><strong>Track list</strong></h2>
<p>$tracks<br/><br/><em>Recorded at $RecordingLocation ($RecordingDate)</em></p>
<h2>Production Team</h2>
<p>Producer: $Producer<br>Engineer: $Engineer</p>
$formattedperformers
<hr>
<p><img src="/GetImage.aspx?IDMF=af86d743-d200-4ec2-b514-738d8e16e8cc&amp;w=200&amp;h=59&amp;src=mc" alt="Apple digital masters badge" title="Apple digital masters badge" class="mediaImage"></p>
EOF
    if [ -f $outpath ]; then
      echo "Written: $outpath"
    else
      echo "There was an error in writing $outpath"
      echo "Exiting..."
      exit 1
    fi
  fi
done < $filepath

