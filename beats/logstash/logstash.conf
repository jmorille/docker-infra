# The # character at the beginning of a line indicates a comment. Use
# comments to describe your configuration.
input {
  beats {
    port => 5044
  }
}


# The filter part of this file is commented out to indicate that it is
# optional.
# filter {
#
# }
output {
  elasticsearch {
    hosts => "integ1:9200"
    manage_template => false
    index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
    document_type => "%{[@metadata][type]}"
  }
}


