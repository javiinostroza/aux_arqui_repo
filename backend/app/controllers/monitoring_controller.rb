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

  def get_elb_graph
 
        creds = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
        cloudwatch = Aws::CloudWatch::Client.new(
            region: 'us-east-2',
            credentials: creds,
        )
 
        resp_1 = cloudwatch.get_metric_widget_image({
          metric_widget: elb_count_sum,
          output_format: "png"
        })

        resp_2 = cloudwatch.get_metric_widget_image({
          metric_widget: elb_active_count_sum,
          output_format: "png"
        })

        resp_3 = cloudwatch.get_metric_widget_image({
          metric_widget: elb_consumed_lc,
          output_format: "png"
        })
  

        @image_1 =  Base64.strict_encode64(resp_1.metric_widget_image)
        @image_2 =  Base64.strict_encode64(resp_2.metric_widget_image)
        @image_3 =  Base64.strict_encode64(resp_3.metric_widget_image)

        graphs = {"cpu": @image_1, "network": @image_2, "failed_status": @image_3}
        render json: graphs
        #send_data resp_1.metric_widget_image, :type => 'image/png', :disposition => 'inline'
    end
    

    def ec2_cpu
      '{
        "metrics": [
            [ "AWS/EC2", "CPUUtilization", "InstanceId", "i-03bc8936b15f61cc0", { "stat": "Average", "id": "m0r0", "label": "travis-auto" } ],
            [ "...", "i-00b1582925124f973", { "stat": "Average", "id": "m0r1", "label": "travis-auto" } ],
            [ "...", "i-03a5c7e84e71375e6", { "stat": "Average", "id": "m0r2", "label": "travis-auto" } ],
            [ "...", "i-0d9f1a3b8e182833b", { "stat": "Average", "id": "m0r3", "label": "travis-auto" } ],
            [ "...", "i-0048802b8b50ac26d", { "stat": "Average", "id": "m0r4", "label": "travis-test" } ],
            [ "...", "i-0b77d7b351cbf6b36", { "stat": "Average", "id": "m0r5", "label": "travis-auto" } ],
            [ "...", "i-0b36ba19daec2e143", { "stat": "Average", "id": "m0r6", "label": "travis-auto" } ],
            [ "...", "i-01e5574c3af89ca81", { "stat": "Average", "id": "m0r7", "label": "travis-auto" } ],
            [ "...", "i-0a7c725057d32a5e5", { "stat": "Average", "id": "m0r8", "label": "travis-asg" } ],
            [ "...", "i-065297c758b245b1e", { "stat": "Average", "id": "m0r9", "label": "Master" } ],
            [ "...", "i-0909bbc9f9ef63f19", { "stat": "Average", "id": "m0r10", "label": "auto-renew" } ],
            [ "...", "i-02d001f301d3b4258", { "stat": "Average", "id": "m0r11", "label": "travis-auto" } ]
        ],
        "title": "CPU Utilization Average",
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

     def ec2_network
      '{
        "metrics": [
            [ "AWS/EC2", "NetworkIn", "InstanceId", "i-03bc8936b15f61cc0", { "stat": "Average", "id": "m0r0", "label": "travis-auto" } ],
            [ "...", "i-00b1582925124f973", { "stat": "Average", "id": "m0r1", "label": "travis-auto" } ],
            [ "...", "i-03a5c7e84e71375e6", { "stat": "Average", "id": "m0r2", "label": "travis-auto" } ],
            [ "...", "i-0d9f1a3b8e182833b", { "stat": "Average", "id": "m0r3", "label": "travis-auto" } ],
            [ "...", "i-0048802b8b50ac26d", { "stat": "Average", "id": "m0r4", "label": "travis-test" } ],
            [ "...", "i-0b77d7b351cbf6b36", { "stat": "Average", "id": "m0r5", "label": "travis-auto" } ],
            [ "...", "i-0b36ba19daec2e143", { "stat": "Average", "id": "m0r6", "label": "travis-auto" } ],
            [ "...", "i-01e5574c3af89ca81", { "stat": "Average", "id": "m0r7", "label": "travis-auto" } ],
            [ "...", "i-0a7c725057d32a5e5", { "stat": "Average", "id": "m0r8", "label": "travis-asg" } ],
            [ "...", "i-065297c758b245b1e", { "stat": "Average", "id": "m0r9", "label": "Master" } ],
            [ "...", "i-0909bbc9f9ef63f19", { "stat": "Average", "id": "m0r10", "label": "auto-renew" } ],
            [ "...", "i-02d001f301d3b4258", { "stat": "Average", "id": "m0r11", "label": "travis-auto" } ]
        ],
        "title": "Network In Average",
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

     def ec2_failed
      '{
        "metrics": [
            [ "AWS/EC2", "StatusCheckFailed_System", "InstanceId", "i-03bc8936b15f61cc0", { "stat": "Sum", "id": "m0r0", "label": "travis-auto" } ],
            [ "...", "i-00b1582925124f973", { "stat": "Sum", "id": "m0r1", "label": "travis-auto" } ],
            [ "...", "i-03a5c7e84e71375e6", { "stat": "Sum", "id": "m0r2", "label": "travis-auto" } ],
            [ "...", "i-0d9f1a3b8e182833b", { "stat": "Sum", "id": "m0r3", "label": "travis-auto" } ],
            [ "...", "i-0048802b8b50ac26d", { "stat": "Sum", "id": "m0r4", "label": "travis-test" } ],
            [ "...", "i-0b77d7b351cbf6b36", { "stat": "Sum", "id": "m0r5", "label": "travis-auto" } ],
            [ "...", "i-0b36ba19daec2e143", { "stat": "Sum", "id": "m0r6", "label": "travis-auto" } ],
            [ "...", "i-01e5574c3af89ca81", { "stat": "Sum", "id": "m0r7", "label": "travis-auto" } ],
            [ "...", "i-0a7c725057d32a5e5", { "stat": "Sum", "id": "m0r8", "label": "travis-asg" } ],
            [ "...", "i-065297c758b245b1e", { "stat": "Sum", "id": "m0r9", "label": "Master" } ],
            [ "...", "i-0909bbc9f9ef63f19", { "stat": "Sum", "id": "m0r10", "label": "auto-renew" } ],
            [ "...", "i-02d001f301d3b4258", { "stat": "Sum", "id": "m0r11", "label": "travis-auto" } ]
        ],
        "title": "Status Check Failed System Sum",
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
        "width": 1649,
        "height": 250,
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
        "width": 1649,
        "height": 250,
        "start": "-PT3H",
        "end": "P0D"
    }'
     end
     
     def elb_count_sum
      '{
        "metrics": [
            [ "AWS/ApplicationELB", "RequestCount", "LoadBalancer", "app/load-balancer-https/8cf6b0f400a8193d", { "stat": "Sum", "id": "m0r0" } ],
            [ "...", "app/simpl-ELBV2-1VHPZ9FZHJYDT/1d1ef333e5288244", { "stat": "Sum", "id": "m0r1" } ],
            [ "...", "app/simpl-ELBV2-1EAWJKGFLDJ9T/3cca24aa58092107", { "stat": "Sum", "id": "m0r2" } ],
            [ "...", "app/simpl-ELBV2-1X4XUOIR0QHN/4c554bc08613ac94", { "stat": "Sum", "id": "m0r3" } ],
            [ "...", "app/simpl-ELBV2-1FIY0BTYDQ99G/0b1624f99c053465", { "stat": "Sum", "id": "m0r4" } ],
            [ "...", "app/simpl-ELBV2-USGGFDXI0GUK/ab4ef064a3fd3e15", { "stat": "Sum", "id": "m0r5" } ],
            [ "...", "app/simpl-ELBV2-XWN7C33VW1LC/845fcdd48427120c", { "stat": "Sum", "id": "m0r6" } ],
            [ "...", "app/simpl-ELBV2-1U615VAMIV9TD/6d4ffed25683f4e4", { "stat": "Sum", "id": "m0r7" } ],
            [ "...", "app/simpl-ELBV2-PU0TOAMT8WUO/ec4b12cae5b3b7e2", { "stat": "Sum", "id": "m0r8" } ],
            [ "...", "app/simpl-ELBV2-I2KSHHER39SJ/d95970aa10aa92a3", { "stat": "Sum", "id": "m0r9" } ],
            [ "...", "app/simpl-ELBV2-1PZSAA4V1NS69/459a3f8880388e21", { "stat": "Sum", "id": "m0r10" } ],
            [ "...", "app/IAAC-ELBV2L-TNWGEAPUBXH7/3799642e781e466c", { "stat": "Sum", "id": "m0r11" } ],
            [ "...", "app/iaac-ELBV2-MKF476L7IDSW/290251fb9d0f7204", { "stat": "Sum", "id": "m0r12" } ],
            [ "...", "app/iaac-ELBV2-KHJ0XUDHW06/1df87cb34ab465ab", { "stat": "Sum", "id": "m0r13" } ],
            [ "...", "app/iaac-ELBV2-1GS9GYA45RIBY/05c27bb17bea9727", { "stat": "Sum", "id": "m0r14" } ],
            [ "...", "app/iaac-ELBV2-1EP5OPA3RSYK2/40f297dd66232802", { "stat": "Sum", "id": "m0r15" } ],
            [ "...", "app/iaac-ELBV2-1WR8UDWIGI7E9/0f3d51b2a3d67b36", { "stat": "Sum", "id": "m0r16" } ],
            [ "...", "app/travis-lb/e8a11dfb653bf289", { "stat": "Sum", "id": "m0r17" } ],
            [ "...", "app/iaac-ELBV2-WKP3C3JQIP9Z/4307ecf1e6ead729", { "stat": "Sum", "id": "m0r18" } ],
            [ "...", "app/simpl-ELBV2-MMUMKWKJK1LB/85082dc56308f29b", { "stat": "Sum", "id": "m0r19" } ],
            [ "...", "app/iaac-ELBV2-XKCAETKC797B/c4c7501d8e03b57c", { "stat": "Sum", "id": "m0r20" } ],
            [ "...", "app/iaac-ELBV2-1P8GHDZWJMH9F/615be552b66485f9", { "stat": "Sum", "id": "m0r21" } ],
            [ "...", "app/iaac-ELBV2-LJTXAHZTUKDT/366071329f350d33", { "stat": "Sum", "id": "m0r22" } ],
            [ "...", "app/iaac-ELBV2-E2GRQPFO51S3/dc03c30f8634659c", { "stat": "Sum", "id": "m0r23" } ],
            [ "...", "app/iaac-ELBV2-GAQLQ4VFX3S/d7c678eeecca2044", { "stat": "Sum", "id": "m0r24" } ],
            [ "...", "app/iaac-ELBV2-KSSEWN3OZKDK/31b64a31d3c8d101", { "stat": "Sum", "id": "m0r25" } ],
            [ "...", "app/iaac-ELBV2-XUWJDYPR98Y7/a9d1b1591ffc2c5c", { "stat": "Sum", "id": "m0r26" } ],
            [ "...", "app/iaac-ELBV2-1GHYPQSQMH2JY/312c1d970fdf959e", { "stat": "Sum", "id": "m0r27" } ],
            [ "...", "app/iaac-ELBV2-1XD8L77B7X2IF/080a9504683b5694", { "stat": "Sum", "id": "m0r28" } ]
        ],
        "title": "Request Count Sum",
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
  
     def elb_active_count_sum
      '{
        "metrics": [
            [ "AWS/ApplicationELB", "ActiveConnectionCount", "LoadBalancer", "app/load-balancer-https/8cf6b0f400a8193d", { "stat": "Sum", "id": "m0r0" } ],
            [ "...", "app/simpl-ELBV2-1VHPZ9FZHJYDT/1d1ef333e5288244", { "stat": "Sum", "id": "m0r1" } ],
            [ "...", "app/simpl-ELBV2-1EAWJKGFLDJ9T/3cca24aa58092107", { "stat": "Sum", "id": "m0r2" } ],
            [ "...", "app/simpl-ELBV2-1X4XUOIR0QHN/4c554bc08613ac94", { "stat": "Sum", "id": "m0r3" } ],
            [ "...", "app/simpl-ELBV2-1FIY0BTYDQ99G/0b1624f99c053465", { "stat": "Sum", "id": "m0r4" } ],
            [ "...", "app/simpl-ELBV2-USGGFDXI0GUK/ab4ef064a3fd3e15", { "stat": "Sum", "id": "m0r5" } ],
            [ "...", "app/simpl-ELBV2-XWN7C33VW1LC/845fcdd48427120c", { "stat": "Sum", "id": "m0r6" } ],
            [ "...", "app/simpl-ELBV2-1U615VAMIV9TD/6d4ffed25683f4e4", { "stat": "Sum", "id": "m0r7" } ],
            [ "...", "app/simpl-ELBV2-PU0TOAMT8WUO/ec4b12cae5b3b7e2", { "stat": "Sum", "id": "m0r8" } ],
            [ "...", "app/simpl-ELBV2-I2KSHHER39SJ/d95970aa10aa92a3", { "stat": "Sum", "id": "m0r9" } ],
            [ "...", "app/simpl-ELBV2-1PZSAA4V1NS69/459a3f8880388e21", { "stat": "Sum", "id": "m0r10" } ],
            [ "...", "app/IAAC-ELBV2L-TNWGEAPUBXH7/3799642e781e466c", { "stat": "Sum", "id": "m0r11" } ],
            [ "...", "app/iaac-ELBV2-MKF476L7IDSW/290251fb9d0f7204", { "stat": "Sum", "id": "m0r12" } ],
            [ "...", "app/iaac-ELBV2-KHJ0XUDHW06/1df87cb34ab465ab", { "stat": "Sum", "id": "m0r13" } ],
            [ "...", "app/iaac-ELBV2-1GS9GYA45RIBY/05c27bb17bea9727", { "stat": "Sum", "id": "m0r14" } ],
            [ "...", "app/iaac-ELBV2-1EP5OPA3RSYK2/40f297dd66232802", { "stat": "Sum", "id": "m0r15" } ],
            [ "...", "app/iaac-ELBV2-1WR8UDWIGI7E9/0f3d51b2a3d67b36", { "stat": "Sum", "id": "m0r16" } ],
            [ "...", "app/travis-lb/e8a11dfb653bf289", { "stat": "Sum", "id": "m0r17" } ],
            [ "...", "app/iaac-ELBV2-WKP3C3JQIP9Z/4307ecf1e6ead729", { "stat": "Sum", "id": "m0r18" } ],
            [ "...", "app/simpl-ELBV2-MMUMKWKJK1LB/85082dc56308f29b", { "stat": "Sum", "id": "m0r19" } ],
            [ "...", "app/iaac-ELBV2-XKCAETKC797B/c4c7501d8e03b57c", { "stat": "Sum", "id": "m0r20" } ],
            [ "...", "app/iaac-ELBV2-1P8GHDZWJMH9F/615be552b66485f9", { "stat": "Sum", "id": "m0r21" } ],
            [ "...", "app/iaac-ELBV2-LJTXAHZTUKDT/366071329f350d33", { "stat": "Sum", "id": "m0r22" } ],
            [ "...", "app/iaac-ELBV2-E2GRQPFO51S3/dc03c30f8634659c", { "stat": "Sum", "id": "m0r23" } ],
            [ "...", "app/iaac-ELBV2-GAQLQ4VFX3S/d7c678eeecca2044", { "stat": "Sum", "id": "m0r24" } ],
            [ "...", "app/iaac-ELBV2-KSSEWN3OZKDK/31b64a31d3c8d101", { "stat": "Sum", "id": "m0r25" } ],
            [ "...", "app/iaac-ELBV2-XUWJDYPR98Y7/a9d1b1591ffc2c5c", { "stat": "Sum", "id": "m0r26" } ],
            [ "...", "app/iaac-ELBV2-1GHYPQSQMH2JY/312c1d970fdf959e", { "stat": "Sum", "id": "m0r27" } ],
            [ "...", "app/iaac-ELBV2-1XD8L77B7X2IF/080a9504683b5694", { "stat": "Sum", "id": "m0r28" } ]
        ],
        "title": "Active Connection Count Sum",
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

     def elb_consumed_lc
      '{
        "metrics": [
            [ "AWS/ApplicationELB", "ConsumedLCUs", "LoadBalancer", "app/load-balancer-https/8cf6b0f400a8193d", { "stat": "Average", "id": "m0r0" } ],
            [ "...", "app/simpl-ELBV2-USGGFDXI0GUK/ab4ef064a3fd3e15", { "stat": "Average", "id": "m0r1" } ],
            [ "...", "app/simpl-ELBV2-1FIY0BTYDQ99G/0b1624f99c053465", { "stat": "Average", "id": "m0r2" } ],
            [ "...", "app/simpl-ELBV2-XWN7C33VW1LC/845fcdd48427120c", { "stat": "Average", "id": "m0r3" } ],
            [ "...", "app/simpl-ELBV2-1U615VAMIV9TD/6d4ffed25683f4e4", { "stat": "Average", "id": "m0r4" } ],
            [ "...", "app/simpl-ELBV2-I2KSHHER39SJ/d95970aa10aa92a3", { "stat": "Average", "id": "m0r5" } ],
            [ "...", "app/simpl-ELBV2-1PZSAA4V1NS69/459a3f8880388e21", { "stat": "Average", "id": "m0r6" } ],
            [ "...", "app/simpl-ELBV2-PU0TOAMT8WUO/ec4b12cae5b3b7e2", { "stat": "Average", "id": "m0r7" } ],
            [ "...", "app/simpl-ELBV2-1EAWJKGFLDJ9T/3cca24aa58092107", { "stat": "Average", "id": "m0r8" } ],
            [ "...", "app/simpl-ELBV2-1VHPZ9FZHJYDT/1d1ef333e5288244", { "stat": "Average", "id": "m0r9" } ],
            [ "...", "app/simpl-ELBV2-1X4XUOIR0QHN/4c554bc08613ac94", { "stat": "Average", "id": "m0r10" } ],
            [ "...", "app/IAAC-ELBV2L-TNWGEAPUBXH7/3799642e781e466c", { "stat": "Average", "id": "m0r11" } ],
            [ "...", "app/iaac-ELBV2-MKF476L7IDSW/290251fb9d0f7204", { "stat": "Average", "id": "m0r12" } ],
            [ "...", "app/travis-lb/e8a11dfb653bf289", { "stat": "Average", "id": "m0r13" } ],
            [ "...", "app/iaac-ELBV2-1WR8UDWIGI7E9/0f3d51b2a3d67b36", { "stat": "Average", "id": "m0r14" } ],
            [ "...", "app/iaac-ELBV2-1GS9GYA45RIBY/05c27bb17bea9727", { "stat": "Average", "id": "m0r15" } ],
            [ "...", "app/iaac-ELBV2-KHJ0XUDHW06/1df87cb34ab465ab", { "stat": "Average", "id": "m0r16" } ],
            [ "...", "app/iaac-ELBV2-1EP5OPA3RSYK2/40f297dd66232802", { "stat": "Average", "id": "m0r17" } ],
            [ "...", "app/iaac-ELBV2-XKCAETKC797B/c4c7501d8e03b57c", { "stat": "Average", "id": "m0r18" } ],
            [ "...", "app/simpl-ELBV2-MMUMKWKJK1LB/85082dc56308f29b", { "stat": "Average", "id": "m0r19" } ],
            [ "...", "app/iaac-ELBV2-WKP3C3JQIP9Z/4307ecf1e6ead729", { "stat": "Average", "id": "m0r20" } ],
            [ "...", "app/iaac-ELBV2-1P8GHDZWJMH9F/615be552b66485f9", { "stat": "Average", "id": "m0r21" } ],
            [ "...", "app/iaac-ELBV2-1GHYPQSQMH2JY/312c1d970fdf959e", { "stat": "Average", "id": "m0r22" } ],
            [ "...", "app/iaac-ELBV2-LJTXAHZTUKDT/366071329f350d33", { "stat": "Average", "id": "m0r23" } ],
            [ "...", "app/iaac-ELBV2-E2GRQPFO51S3/dc03c30f8634659c", { "stat": "Average", "id": "m0r24" } ],
            [ "...", "app/iaac-ELBV2-KSSEWN3OZKDK/31b64a31d3c8d101", { "stat": "Average", "id": "m0r25" } ],
            [ "...", "app/iaac-ELBV2-GAQLQ4VFX3S/d7c678eeecca2044", { "stat": "Average", "id": "m0r26" } ],
            [ "...", "app/iaac-ELBV2-XUWJDYPR98Y7/a9d1b1591ffc2c5c", { "stat": "Average", "id": "m0r27" } ],
            [ "...", "app/iaac-ELBV2-1XD8L77B7X2IF/080a9504683b5694", { "stat": "Average", "id": "m0r28" } ]
        ],
        "title": "Consumed LC Us Average",
        "legend": {
            "position": "right"
        },
        "copilot": true,
        "view": "timeSeries",
        "stacked": false,
        "width": 1649,
        "height": 250,
        "start": "-PT3H",
        "end": "P0D"
    }'
     end


  end
  