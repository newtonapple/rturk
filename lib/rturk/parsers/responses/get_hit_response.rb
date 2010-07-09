# Parses the GetHIT Response
#
# <?xml version="1.0"?>
# <GetHITResponse>
#   <OperationRequest>
#     <RequestId>49341251-fcbd-45c3-ab98-8fbe2e4d8060</RequestId>
#   </OperationRequest>
#   <HIT>
#     <Request>
#       <IsValid>True</IsValid>
#     </Request>
#     <HITId>GR4R3HY3YGBZXDCAPJWZ</HITId>
#     <HITTypeId>YGKZ2W5X6YFZ08ZRXXZZ</HITTypeId>
#     <CreationTime>2009-06-25T04:21:17Z</CreationTime>
#     <Title>Write a twitter update</Title>
#     <Description>Simply write a twitter update for me</Description>
#     <Question>&lt;ExternalQuestion xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd"&gt;
#   &lt;ExternalURL&gt;http://s3.amazonaws.com/mpercival.com/newtweet.html?id=foo&lt;/ExternalURL&gt;
#   &lt;FrameHeight&gt;400&lt;/FrameHeight&gt;
# &lt;/ExternalQuestion&gt;
# </Question>
#     <Keywords>twitter, blogging, writing, english</Keywords>
#     <HITStatus>Reviewable</HITStatus>
#     <MaxAssignments>1</MaxAssignments>
#     <Reward>
#       <Amount>0.10</Amount>
#       <CurrencyCode>USD</CurrencyCode>
#       <FormattedPrice>$0.10</FormattedPrice>
#     </Reward>
#     <AutoApprovalDelayInSeconds>3600</AutoApprovalDelayInSeconds>
#     <Expiration>2009-06-25T05:21:17Z</Expiration>
#     <AssignmentDurationInSeconds>3600</AssignmentDurationInSeconds>
#     <NumberOfSimilarHITs>0</NumberOfSimilarHITs>
#     <RequesterAnnotation>OptionalNote</RequesterAnnotation>
#     <QualificationRequirement>
#       <QualificationTypeId>000000000000000000L0</QualificationTypeId>
#       <Comparator>GreaterThan</Comparator>
#       <IntegerValue>90</IntegerValue>
#       <RequiredToPreview>0</RequiredToPreview>
#     </QualificationRequirement>
#     <HITReviewStatus>NotReviewed</HITReviewStatus>
#   </HIT>
# </GetHITResponse>

module RTurk
  class GetHITResponse < Response
    attr_reader :hit_id, :type_id, :status, :review_status, :title, :note, :created_at, :expires_at,
                :assignments_duration, :reward_amount, :max_assignments, :auto_approval_delay,
                :keywords

    def initialize(response)
      @raw_xml = response.body
      @xml = Nokogiri::XML(@raw_xml)
      raise_errors
      map_content(@xml.xpath('//HIT'),
        :hit_id => 'HITId',
        :type_id => 'HITTypeId',
        :keywords => 'Keywords',
        :status => 'HITStatus',
        :review_status => 'HITReviewStatus',
        :title => 'Title',
        :note  => 'RequesterAnnotation',
        :created_at => 'CreationTime',
        :expires_at => 'Expiration',
        :assignments_duration => 'AssignmentDurationInSeconds',
        :reward_amount => 'Reward/Amount',
        :max_assignments => 'MaxAssignments',
        :auto_approval_delay => 'AutoApprovalDelayInSeconds'
      )

      @keywords = @keywords.split(', ') if @keywords
    end
  end
end
