#!/bin/sh

# 04.2.qc-taskFT-parallelSessions.sh

parallelQcRuns=$1
niftiDirProject=/data/panolocal/processedOnPano-hackney/derivedData

ls -d ${niftiDirProject}/* | parallel --jobs ${parallelQcRuns} --tag --line-buffer ~stowler-local/src.mywork.gitRepos/proj.mh.cda2/04.1.qc-taskFT-singleSession.sh {}
