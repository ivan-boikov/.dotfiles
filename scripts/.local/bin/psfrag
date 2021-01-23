#!/bin/bash

#default args for my card, most likely not enough for some cards
#user is expected to input values anyway
FRAGMENTS=${1:-1}
FRAGMENT_SIZE=${2:-1000}

echo "Fragments x fragment size:" $FRAGMENTS "x" $FRAGMENT_SIZE

ACTIVE_CARD_NAME=$(pactl list sinks short | grep RUNNING | cut -f 2 | sed "s/\.[^.]*$//g" | sed "s/^[^.]*\.//g")
MODULE=$(pactl list modules short | grep "$ACTIVE_CARD_NAME")

ID=$(echo "$MODULE" | cut -f 1)
ARGS=$(echo "$MODULE" | cut -f3-)

if [ -z $ACTIVE_CARD_NAME ]; then
  echo "Failed to get active sink. Play some music?"
  exit 1
fi

echo "Active sink name:" $ACTIVE_CARD_NAME
echo "Module ID:" $ID


echo "tsched"
if [[ $ARGS == *"tsched"* ]]; then
  echo "    found, replacing to 0"
  ARGS=$(sed "s/tsched=\S*/tsched=0/g" <<< "$ARGS")
else
  echo "    not found, adding 0"
  ARGS="$ARGS tsched=0"
fi


echo "fixed_latency_range"
if [[ $ARGS == *"fixed_latency_range"* ]]; then
  echo "    found, replacing with yes"
  ARGS=$(sed "s/fixed_latency_range=\S*/fixed_latency_range=yes/g" <<< "$ARGS")
else
  echo "    not found, adding yes"
  ARGS="$ARGS fixed_latency_range=yes"
fi


echo "fragments"
if [[ $ARGS == *"fragments"* ]]; then
  echo "    found, replacing with" $FRAGMENTS
  ARGS=$(sed "s/fragments=\S*/fragments=$FRAGMENTS/g" <<< "$ARGS")
else
  echo "    not found, adding" $FRAGMENTS
  ARGS="$ARGS fragments=1"
fi


echo "fragment_size"
if [[ $ARGS == *"fragment_size"* ]]; then
  echo "    found, replacing with" $FRAGMENT_SIZE
  ARGS=$(sed "s/fragment_size=\S*/fragment_size=$FRAGMENT_SIZE/g" <<< "$ARGS")
else
  echo "    not found, adding" $FRAGMENT_SIZE
  ARGS="$ARGS fragment_size=$FRAGMENT_SIZE"
fi
  
pactl unload-module "$ID"
pactl load-module module-alsa-card "$ARGS"
