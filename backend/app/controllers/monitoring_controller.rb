require 'net/http'
require 'aws-sdk'
require "base64"
require 'tempfile'

class MonitoringController < ActionController::API
  
    def get_ec2_graph
 
        creds = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
        cloudwatch = Aws::CloudWatch::Client.new(
            region: 'us-east-2',
            credentials: creds,
        )
 
        resp_1 = cloudwatch.get_metric_widget_image({
          metric_widget: ec2_cpu,
          output_format: "png"
        })

        resp_2 = cloudwatch.get_metric_widget_image({
          metric_widget: ec2_network,
          output_format: "png"
        })

        resp_3 = cloudwatch.get_metric_widget_image({
          metric_widget: ec2_failed,
          output_format: "png"
        })
  

        @image_1 =  Base64.strict_encode64(resp_1.metric_widget_image)
        @image_2 =  Base64.strict_encode64(resp_2.metric_widget_image)
        @image_3 =  Base64.strict_encode64(resp_3.metric_widget_image)

        graphs = {"cpu": @image_1, "network": @image_2, "failed_status": @image_3}
        render json: graphs
        # send_data resp_3.metric_widget_image, :type => 'image/png', :disposition => 'inline'
    end

    def get_s3_graph
 
      creds = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
      cloudwatch = Aws::CloudWatch::Client.new(
          region: 'us-east-2',
          credentials: creds,
      )

      resp_1 = cloudwatch.get_metric_widget_image({
        metric_widget: s3_bucket_size,
        output_format: "png"
      })

      resp_2 = cloudwatch.get_metric_widget_image({
        metric_widget: s3_objects_number,
        output_format: "png"
      })



      @image_1 =  Base64.strict_encode64(resp_1.metric_widget_image)
      @image_2 =  Base64.strict_encode64(resp_2.metric_widget_image)

      graphs = {"bucket_size": @image_1, "objects_number": @image_2}
      render json: graphs
      # send_data resp_3.metric_widget_image, :type => 'image/png', :disposition => 'inline'
  end

    

    def ec2_cpu
      '{
       "metrics": [
           [ "AWS/EC2", "CPUUtilization", "InstanceId", "i-0048802b8b50ac26d", { "stat": "Average", "id": "m0r0", "label": "travis-test" } ],
           [ "...", "i-0a00c317000ba9a77", { "stat": "Average", "id": "m0r1", "label": "travis-auto" } ],
           [ "...", "i-065297c758b245b1e", { "stat": "Average", "id": "m0r2", "label": "Master" } ],
           [ "...", "i-0909bbc9f9ef63f19", { "stat": "Average", "id": "m0r3", "label": "auto-renew" } ]
       ],
       "title": "CPU Utilization Average",
       "copilot": true,
       "legend": {
           "position": "bottom"
       },
       "view": "timeSeries",
       "stacked": false,
       "width": 1095,
       "height": 187,
       "start": "-PT3H",
       "end": "P0D"
   }'
     end

     def ec2_network
      '{
        "metrics": [
            [ "AWS/EC2", "NetworkIn", "InstanceId", "i-0048802b8b50ac26d", { "stat": "Average", "id": "m0r0", "label": "travis-test" } ],
            [ "...", "i-0a00c317000ba9a77", { "stat": "Average", "id": "m0r1", "label": "travis-auto" } ],
            [ "...", "i-065297c758b245b1e", { "stat": "Average", "id": "m0r2", "label": "Master" } ],
            [ "...", "i-0909bbc9f9ef63f19", { "stat": "Average", "id": "m0r3", "label": "auto-renew" } ]
        ],
        "title": "Network In Average",
        "copilot": true,
        "legend": {
            "position": "bottom"
        },
        "view": "timeSeries",
        "stacked": false,
        "width": 1095,
        "height": 187,
        "start": "-PT3H",
        "end": "P0D"
    }'
     end

     def ec2_failed
      '{
        "metrics": [
            [ "AWS/EC2", "StatusCheckFailed_System", "InstanceId", "i-0048802b8b50ac26d", { "stat": "Sum", "id": "m0r0", "label": "travis-test" } ],
            [ "...", "i-0a00c317000ba9a77", { "stat": "Sum", "id": "m0r1", "label": "travis-auto" } ],
            [ "...", "i-065297c758b245b1e", { "stat": "Sum", "id": "m0r2", "label": "Master" } ],
            [ "...", "i-0909bbc9f9ef63f19", { "stat": "Sum", "id": "m0r3", "label": "auto-renew" } ]
        ],
        "title": "Status Check Failed System Sum",
        "copilot": true,
        "legend": {
            "position": "bottom"
        },
        "view": "timeSeries",
        "stacked": false,
        "width": 1095,
        "height": 187,
        "start": "-PT3H",
        "end": "P0D"
    }'
     end

     def s3_bucket_size
      '{
        "metrics": [
            [ "AWS/S3", "BucketSizeBytes", "BucketName", "16arqsis-travis-s3", "StorageType", "StandardStorage", { "stat": "Average", "id": "m0r0" } ],
            [ "...", "16arqsisv2-css", ".", ".", { "stat": "Average", "id": "m0r1" } ],
            [ "...", "cdnfront16arqsis", ".", ".", { "stat": "Average", "id": "m0r2" } ],
            [ "...", "cf-templates-akvhsakv6lev-us-east-2", ".", ".", { "stat": "Average", "id": "m0r3" } ],
            [ "...", "chat-reacts3", ".", ".", { "stat": "Average", "id": "m0r4" } ],
            [ "...", "reacts3-chat", ".", ".", { "stat": "Average", "id": "m0r5" } ]
        ],
        "title": "Bucket Size Bytes Average",
        "legend": {
            "position": "right"
        },
        "copilot": true,
        "view": "timeSeries",
        "stacked": false,
        "width": 1095,
        "height": 187,
        "start": "-PT3H",
        "end": "P0D"
    }'
     end

     def s3_objects_number
      '{
        "metrics": [
            [ "AWS/S3", "NumberOfObjects", "BucketName", "16arqsis-travis-s3", "StorageType", "AllStorageTypes", { "stat": "Average", "id": "m0r0" } ],
            [ "...", "16arqsisv2-css", ".", ".", { "stat": "Average", "id": "m0r1" } ],
            [ "...", "cdnfront16arqsis", ".", ".", { "stat": "Average", "id": "m0r2" } ],
            [ "...", "cf-templates-akvhsakv6lev-us-east-2", ".", ".", { "stat": "Average", "id": "m0r3" } ],
            [ "...", "chat-reacts3", ".", ".", { "stat": "Average", "id": "m0r4" } ],
            [ "...", "reacts3-chat", ".", ".", { "stat": "Average", "id": "m0r5" } ]
        ],
        "title": "Number Of Objects Average",
        "legend": {
            "position": "right"
        },
        "copilot": true,
        "view": "timeSeries",
        "stacked": false,
        "width": 1095,
        "height": 187,
        "start": "-PT3H",
        "end": "P0D"
    }'
     end

     




  end
  