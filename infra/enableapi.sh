#!/bin/sh

gcloud services enable \
    cloudapis.googleapis.com \
    sql-component.googleapis.com \
    sqladmin.googleapis.com \
    run.googleapis.com \
    compute.googleapis.com \
    cloudbuild.googleapis.com \
    secretmanager.googleapis.com \
    artifactregistry.googleapis.com \
    cloudscheduler.googleapis.com \
    domains.googleapis.com \
    dns.googleapis.com \
    runapps.googleapis.com
    