#!/usr/bin/env bash

workflow_filename=mjolnir.alfredworkflow
cd alfred_workflow && zip -r /tmp/$workflow_filename ./* && open /tmp/$workflow_filename
