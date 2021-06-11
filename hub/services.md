# Services Table

[//]: # "variables are defined in 'out-run.sh'"

| PATH_OF_SERVICE | ARGUMENTS                                                                | DELAY | API                      | REDIRECT                                          | METHOD | ENABLE |
| :-------------- | :----------------------------------------------------------------------- | :---: | :----------------------- | :------------------------------------------------ | :----: | :----: |
| $NSS            |                                                                          | 0,10  |                          |                                                   |        |  true  |
| $N3             |                                                                          |  1,2  | /n3/admin/newdemocontext | <http://$N3_HOST:$N3_PORT/admin/newdemocontext>   |  POST  |  true  |
|                 |                                                                          |       | /n3/graphgl              | <http://$N3_HOST:$N3_PORT/n3/graphgl>             |  POST  |  true  |
|                 |                                                                          |       | /n3/publish              | <http://$N3_HOST:$N3_PORT/n3/publish>             |  POST  |  true  |
| $OTF_READER     | --folder=$PDM_ROOT/in/maps/align --config=./config/alignMaps_config.json |   2   |                          |                                                   |        |  true  |
| $OTF_READER     | --folder=$PDM_ROOT/in/maps/level --config=./config/levelMaps_config.json |   2   |                          |                                                   |        |  true  |
| $OTF_READER     | --folder=$PDM_ROOT/in/brightpath --config=./config/bp_config.json        |   2   |                          |                                                   |        |  true  |
| $OTF_READER     | --folder=$PDM_ROOT/in/lpofa --config=./config/lpofa_literacy_config.json |   2   |                          |                                                   |        |  true  |
| $OTF_READER     | --folder=$PDM_ROOT/in/lpofa --config=./config/lpofa_numeracy_config.json |   2   |                          |                                                   |        |  true  |
| $OTF_READER     | --folder=$PDM_ROOT/in/maths-pathway --config=./config/mp_config.json     |   2   |                          |                                                   |        |  true  |
| $OTF_READER     | --folder=$PDM_ROOT/in/spa --config=./config/spa_mapped_config.json       |   2   |                          |                                                   |        |  true  |
| $OTF_READER     | --folder=$PDM_ROOT/in/spa --config=./config/spa_prescribed_config.json   |   2   |                          |                                                   |        |  true  |
| $OTF_CLASSIFIER |                                                                          |   2   | /classifier/align        | <http://$CLASSIFIER_HOST:$CLASSIFIER_PORT/align>  |  POST  |  true  |
|                 |                                                                          |       | /classifier/align        | <http://$CLASSIFIER_HOST:$CLASSIFIER_PORT/align>  |  GET   |  true  |
|                 |                                                                          |       | /classifier/lookup       | <http://$CLASSIFIER_HOST:$CLASSIFIER_PORT/lookup> |  GET   |  true  |
|                 |                                                                          |       | /classifier/index        | <http://$CLASSIFIER_HOST:$CLASSIFIER_PORT/index>  |  GET   |  true  |
| $OTF_ALIGN      | --port=$ALIGNER_PORT                                                     |   2   | /aligner                 | <http://$ALIGNER_HOST:$ALIGNER_PORT/>             |  GET   |  true  |
|                 |                                                                          |       | /aligner/align           | <http://$ALIGNER_HOST:$ALIGNER_PORT/align>        |  POST  |  true  |
| $OTF_LEVEL      | --port=$LEVELLER_PORT                                                    |   2   | /leveler                 | <http://$LEVELLER_HOST:$LEVELLER_PORT/>           |  GET   |  true  |
|                 |                                                                          |       | /leveler/level           | <http://$LEVELLER_HOST:$LEVELLER_PORT/level>      |  POST  |  true  |
| $BENTHOS        | -c ~/Desktop/OTF/otf-hub/benthos/maps/align.yaml                         |   3   |                          |                                                   |        |  true  |
| $BENTHOS        | -c ~/Desktop/OTF/otf-hub/benthos/maps/level.yaml                         |   3   |                          |                                                   |        |  true  |
| $BENTHOS        | -c ~/Desktop/OTF/otf-hub/benthos/data.yaml                               |   3   |                          |                                                   |        |  true  |
| ./otf-run.sh    |                                                                          |   0   |                          |                                                   |        |  true  |
