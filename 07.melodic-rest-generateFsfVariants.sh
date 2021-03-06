#!/bin/sh

# 07.melodic-rest-generateFsfVariants.sh 
#
# Use existing melodic fsf files from a single session to generate melodic fsf
# files for many sessions.
#
# Assumes pwd is parent directory of a child directory that contains
# per-session fsf files. For example:
# 
# $ pwd
# /home/stowler-local/src.mywork.gitRepos/proj.mh.cda2/melodic-fsfFiles-rest
# 
# $ tree -L 2 | head
# .
# └── omt001s01-fsfFiles-rest
#     └── omt001s01.fmri.rest.run1.melodicFixNone_design.fsf
#
#

# sessionIDlist for pano re-processing 20150903-10,  and maybe later:
# ...NB: I'm omitting the template (omt001s01) from this list to avoid recursion:
sessionIDlist="omt002s01 omt003s01 omt004s01 omt006s01 omt007s01 omt008s01 omt009s01 omt010s01 omt011s01 omt012s01 omt013s01 omt015s01 omt021s01 omt022s01 omt023s01 omt024s01 omt025s01 omt027s01 omt028s01 omt029s01 omt030s01 omt031s01 omt102s01 omt102s02 omt103s01 omt105s01 omt106s01 omt106s02 omt108s01 omt108s02 omt110s01 omt110s02 omt111s01 omt113s01 omt114s01 omt115s01 omt116s01 omt117s01 omt119s01 omt120s01 omt121s01 omt202s01 omt203s01 omt203s02 omt204s01 omt204s02 omt205s01 omt205s02 omt206s01 omt206s02 omt207s01 omt207s02 omt211s01 omt211s02 omt214s01 omt215s01 omt219s01 omt220s01 omt221s01 omt301s01 omt301s02 omt302s01 omt302s02 omt304s01 omt304s02 omt305s01 omt305s02 omt308s01 omt308s02 omt310s01 omt310s02 omt311s01 omt311s02 omt312s01 omt312s02 omt314s01 omt314s02 omt315s01 omt315s02 omt317s01 omt317s02 omt318s01 omt320s01 omt994s01 omt995s01 omt997s01"

# directory containing single-session fsf files that will act as template for
# other sessions:
fsfTemplateDir=omt001s01-fsfFiles-rest

for sessionID in `echo ${sessionIDlist}`; do
   newSessionID="$sessionID"

   # create a copy of the existing template directory:
   newFsfDir=${newSessionID}-fsfFiles-rest
   cp -r ${fsfTemplateDir} ${newFsfDir}

   # change fsf file names to reflect new sessionID:
   for file in ${newFsfDir}/*.fsf; do 
      fsfBasename=`basename ${file}`
      fsfSuffix=`echo ${fsfBasename} | sed 's/omt.......//g'`
      #echo "fsfBasename is ${fsfBasename}"
      #echo "fsfSuffix is ${fsfSuffix}"
      mv ${file} ${newFsfDir}/${newSessionID}.${fsfSuffix}
   done

   # change the filepaths inside of the fsf file to reflect the newSessionID:
   for file in ${newFsfDir}/*.fsf; do
      du -sh $file
      sed -i '' "s/omt001s01/${newSessionID}/g" $file
      ls -al $file
   done

done

