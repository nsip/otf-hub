#!/bin/bash

set -e

echo "OTF PDM"

###export
NATS_HOST=127.0.0.1  # benthos 
N3_HOST=127.0.0.1
N3_PORT=1323
CLASSIFIER_HOST=127.0.0.1
CLASSIFIER_PORT=1576
ALIGNER_HOST=127.0.0.1
ALIGNER_PORT=1324
LEVELLER_HOST=127.0.0.1
LEVELLER_PORT=1327
WEIGHTING_HOST=127.0.0.1
WEIGHTING_PORT=1329
PDM_ROOT=~/Desktop/OTF/otf-hub/otfdata

OTF_ROOT=~/Desktop/OTF
NSS=$OTF_ROOT/nats-streaming-server-v0.22.0-linux-amd64/nats-streaming-server
N3=$OTF_ROOT/n3-web/server/n3w/n3w
OTF_READER=$OTF_ROOT/otf-reader/cmd/otf-reader/otf-reader
OTF_CLASSIFIER=$OTF_ROOT/otf-classifier/build/Linux64/otf-classifier/otf-classifier
OTF_ALIGN=$OTF_ROOT/otf-align/cmd/otf-align/otf-align
OTF_LEVEL=$OTF_ROOT/otf-level/cmd/otf-level/otf-level
OTF_TESTDATA=$OTF_ROOT/otf-testdata
BENTHOS=~/Desktop/OTF/benthos3480/benthos
###

# create demo input/audit/nats folder structure
mkdir -p ${PDM_ROOT}/{in/{brightpath,lpofa,maps/{align,level},maths-pathway,spa},audit/{align,level}}

# remove existing contexts
rm -rf /home/qmiao/Desktop/OTF/n3/n3-web/server/n3w/contexts

# create new contexts
sleep 4
curl -s -X POST http://${N3_HOST}:${N3_PORT}/admin/newdemocontext -d userName=nsipOtf -d contextName=alignmentMaps
curl -s -X POST http://${N3_HOST}:${N3_PORT}/admin/newdemocontext -d userName=nsipOtfLevel -d contextName=levellingMaps

# maps
sleep 4
cp ${OTF_TESTDATA}/pdm_testdata/maps/alignmentMaps/nlpLinks.csv  ${PDM_ROOT}/in/maps/align
sleep 4
cp ${OTF_TESTDATA}/pdm_testdata/maps/alignmentMaps/providerItems.csv  ${PDM_ROOT}/in/maps/align
sleep 4
cp ${OTF_TESTDATA}/pdm_testdata/maps/levelMaps/scaleMap.csv  ${PDM_ROOT}/in/maps/level
sleep 4
cp ${OTF_TESTDATA}/pdm_testdata/maps/levelMaps/scoresMap.csv  ${PDM_ROOT}/in/maps/level

# data
sleep 4
cp ${OTF_TESTDATA}/pdm_testdata/BrightPath.json.brightpath ${PDM_ROOT}/in/brightpath
sleep 4
cp ${OTF_TESTDATA}/pdm_testdata/MathsPathway.csv ${PDM_ROOT}/in/maths-pathway

sleep 20m