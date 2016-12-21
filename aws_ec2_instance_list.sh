#!/bin/bash

for R in $(aws ec2 describe-regions --query="[Regions][*][*][RegionName]" --output text)
do
	echo $R ----------
	aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,PrivateIpAddress,State.Name]' --output text --region=$R
done

