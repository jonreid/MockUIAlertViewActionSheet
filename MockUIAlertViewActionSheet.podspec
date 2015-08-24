Pod::Spec.new do |s|
  s.name     = 'MockUIAlertViewActionSheet'
  s.version  = '1.0.0'
  s.summary  = 'Mock classic alerts and action sheets for unit tests'
  s.description = <<-DESC
                    MockUIAlertViewActionSheet lets you mock old-style iOS alerts and action sheets for unit tests, based on the UIAlertView and UIActionSheet.

                    No actual alerts are presented. This means:

                    * The workflow doesn't pause for an action to be selected.
                    * Tests are blazing fast.
                  DESC
  s.homepage = 'https://github.com/jonreid/MockUIAlertViewActionSheet'
  s.license  = 'MIT'
  s.author   = { 'Jon Reid' => 'jon@qualitycoding.org' }
  s.social_media_url = 'https://twitter.com/qcoding'
    
  s.ios.deployment_target = '8.0'
  s.source   = { :git => 'https://github.com/jonreid/MockUIAlertViewActionSheet.git', :tag => 'v1.0.0' }
  s.source_files = 'TestSupport/*.{h,m}'
  s.requires_arc = true
end