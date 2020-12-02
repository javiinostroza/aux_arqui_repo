require 'net/http'
require 'aws-sdk'
require "base64"

class MonitoringController < ActionController::API
  
    def get_graph
        puts 'GETTING GRAPH'
        creds = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
        cloudwatch = Aws::CloudWatch::Client.new(
            region: 'us-east-2',
            credentials: creds,
        )
        #url = URI.parse('http://169.254.169.254/latest/meta-data/instance-id')
        #req = Net::HTTP::Get.new(url.to_s)
        #res = Net::HTTP.start(url.host, url.port) {|http|
        #  http.request(req)
        #}
        #instance_id = res.body;
        instance_id = 'i-0a00c317000ba9a77';
        resp = cloudwatch.get_metric_widget_image({
          metric_widget: metric_widget_param,
          output_format: "png"
        })
        puts "INSTANCE ID", instance_id
        puts "-------------------------"
        puts resp.is_a?(Hash)
        #puts decoded.to_s
        #File.open('graph.png', 'w') { |file| file.write(decoded) }
        File.open('grafico1.png', 'wb') do |f|
          f.write(Base64.decode64(resp[:metric_widget_image]))
        end
        @image = Base64.decode64(resp[:metric_widget_image])
        #render json: {"message": "f"}
    end

    def metric_widget_param
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
  end
  