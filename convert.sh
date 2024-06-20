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
while IFS='|' read -r AlbumTitle AlbumWriter SubOrg AlbumFeatArtists ReleaseDate CatNum AppleURL SpotifyURL YouTubeURL PrestoURL Description Track1 Track1Dur Track2 Track2Dur Track3 Track3Dur RecordingLocation Producer Engineer Performers MFiT; do
  if ((skip_headers)); then
    ((skip_headers--))
  else
    outpath=$(echo ${outdir}/${CatNum}.html)
    if [ $SpotifyURL ]; then
      spotifypath=$(echo $SpotifyURL | sed -E 's/.*\/(album|track)\///; s/=.*//')
      echo "https://open.spotify.com/embed/album/${spotifypath}?utm_source=generator"
    fi
: <<"COMMENT"
    cat <<EOF > $outpath
<table border="1" style="border: 1px #EBEBEB; width: 100.02%;">
<tbody>
<tr>
<td style="background-color: #ebebeb;"><img src="/GetImage.aspx?IDMF=6267e45c-4b32-4667-808a-196a7fbfa87d&amp;w=500&amp;h=500&amp;src=mc" alt="" title="" class="mediaImage"></td>
<td style="background-color: #ebebeb;">
<h3><strong>$AlbumTitle</strong></h3>
$AlbumWriter<br><br><strong>$SubOrg</strong><br>$AlbumFeatArtists<br>Released $ReleaseDate<br><strong>$CatNum</strong></td>
</tr>
</tbody>
</table>
<hr>
<p class="tinymcewrapper-remove">$Description</p>
<h2>Listen now</h2>
<p><iframe width="100%" height="152" style="border-radius: 12px;" src="https://open.spotify.com/embed/track/3CsoQAM0pi8iGDxeGdsVyP?utm_source=generator" frameborder="0" allowfullscreen="allowfullscreen" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe></p>
<p style="text-align: left;"><a href="https://www.nycgb.org.uk/appeal/fortissimo-friend" class="button-pink">Apple music <i class="fa fa-music" aria-hidden="true"></i></a><a href="https://www.nycgb.org.uk/appeal/forte-friend" target="_blank" rel="noopener" class="button-pink">Spotify <i class="fa fa-spotify" aria-hidden="true"></i></a><a href="https://www.nycgb.org.uk/appeal/mezzo-forte-friend" target="_blank" rel="noopener" class="button-pink">Youtube music <i class="fa fa-youtube-play" aria-hidden="true"></i></a></p>
<p></p>
<h2><strong>Track list</strong></h2>
<p>1. Grow (Sarah Quartel) &ndash; 04:53 <br><em>Recorded at Queen Margaret&rsquo;s School, Escrick (12th April 2024) </em></p>
<h2>Production Team</h2>
<p>Producer: Josh Quinlan <br>Engineer: David Jones</p>
<h2>Performers</h2>
<p>List of everyone that sang on this recording.</p>
<hr>
<p><img src="/GetImage.aspx?IDMF=af86d743-d200-4ec2-b514-738d8e16e8cc&amp;w=200&amp;h=59&amp;src=mc" alt="Apple digital masters badge" title="Apple digital masters badge" class="mediaImage"></p>
    EOF
    echo $outpath
COMMENT
  fi
done < $filepath


