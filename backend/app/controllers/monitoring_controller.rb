class MonitoringController < ActionController::API
  
    def get_graph
        puts 'GETTING GRAPH'
        creds = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
        cloudwatch = Aws::CloudWatch::Client.new(
            region: 'us-east-2',
            credentials: creds,
        )
        resp = cloudwatch.get_metric_widget_image({
            metric_widget: [ "AWS/EC2", "CPUUtilization", "InstanceId", "i-01234567890123456" ], # required
            output_format: "OutputFormat",
          })
        render json: {"message": "monitor"}
    end

  end
  