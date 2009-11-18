module RTurk
  # <SearchHITsResult>
  #   <Request>
  #     <IsValid>True</IsValid>
  #   </Request>
  #   <NumResults>2</NumResults>
  #   <TotalNumResults>2</TotalNumResults>
  #   <PageNumber>1</PageNumber>
  # 
  #   <HIT>
  #     <HITId>GBHZVQX3EHXZ2AYDY2T0</HITId>
  #     <HITTypeId>NYVZTQ1QVKJZXCYZCZVZ</HITTypeId>
  #     <CreationTime>2009-04-22T00:17:32Z</CreationTime>
  #     <Title>Location</Title>
  #     <Description>Select the image that best represents</Description>
  #     <HITStatus>Reviewable</HITStatus>
  #     <MaxAssignments>1</MaxAssignments>
  #     <Reward>
  #       <Amount>5.00</Amount>
  #       <CurrencyCode>USD</CurrencyCode>
  #       <FormattedPrice>$5.00</FormattedPrice>
  #     </Reward>
  #     <AutoApprovalDelayInSeconds>2592000</AutoApprovalDelayInSeconds>
  #     <Expiration>2009-04-29T00:17:32Z</Expiration>
  #     <AssignmentDurationInSeconds>30</AssignmentDurationInSeconds>
  #     <NumberOfAssignmentsPending>0</NumberOfAssignmentsPending>
  #     <NumberOfAssignmentsAvailable>0</NumberOfAssignmentsAvailable>
  #     <NumberOfAssignmentsCompleted>1</NumberOfAssignmentsCompleted>
  #   </HIT>
  # 
  #   <HIT>
  #     <HITId>ZZRZPTY4ERDZWJ868JCZ</HITId>
  #     <HITTypeId>NYVZTQ1QVKJZXCYZCZVZ</HITTypeId>
  #     <CreationTime>2009-07-07T00:56:40Z</CreationTime>
  #     <Title>Location</Title>
  #     <Description>Select the image that best represents</Description>
  #     <HITStatus>Assignable</HITStatus>
  #     <MaxAssignments>1</MaxAssignments>
  #     <Reward>
  #       <Amount>5.00</Amount>
  #       <CurrencyCode>USD</CurrencyCode>
  #       <FormattedPrice>$5.00</FormattedPrice>
  #     </Reward>
  #     <AutoApprovalDelayInSeconds>2592000</AutoApprovalDelayInSeconds>
  #     <Expiration>2009-07-14T00:56:40Z</Expiration>
  #     <AssignmentDurationInSeconds>30</AssignmentDurationInSeconds>
  #     <NumberOfAssignmentsPending>0</NumberOfAssignmentsPending>
  #     <NumberOfAssignmentsAvailable>1</NumberOfAssignmentsAvailable>
  #     <NumberOfAssignmentsCompleted>0</NumberOfAssignmentsCompleted>
  #   </HIT>
  # </SearchHITsResult>
  
  class SearchHITsResponse < Response
    attr_reader :page_size, :total_size, :page_number
    
    def initialize(response)
      @raw_xml = response
      @xml = Nokogiri::XML(@raw_xml)
      raise_errors
      map_content(@xml.xpath('//SearchHITsResult'),
        :page_size => 'NumResults',
        :total_size => 'TotalNumResults',
        :page_number => 'PageNumber'
      )
    end
    
    def hits
      @hits ||= begin
        @xml.xpath('//HIT').inject([]) do |arr, hit_xml|
          arr << HITParser.new(hit_xml); arr
        end
      end
    end
    
  end
  
end