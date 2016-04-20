#!/bin/sh

state="OFF"

while true;
do

   if [ $(ps -el | grep ursula | wc -l) -gt "0" ]
   then
      if [ "$state" = "OFF" ];
      then
         state="ON"
         curl -X POST -H 'Content-type: application/json' --data '{"text":"Ursula run started!"}' https://hooks.slack.com/services/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
      fi
   else
      if [ "$state" = "ON" ];
      then
         state="OFF"
         curl -X POST -H 'Content-type: application/json' --data '{"text":"Ursula run finished!"}' https://hooks.slack.com/services/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
      fi
   fi

   sleep 1
done

