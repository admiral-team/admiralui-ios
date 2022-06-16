#
#  Be sure to run `pod spec lint libui.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.platform = :ios
  spec.name         = "AdmiralSwiftUI"
  spec.version      = "9.0.0"
  spec.summary      = "Team UI Components."

  spec.description  = <<-DESC
  UI components library.
                   DESC

  spec.homepage     = "https://github.com/admiral-team/admiralui-ios"

  spec.license      = { :type => 'MIT License', :text => <<-LICENSE
    Copyright (c) 2020 OOO

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
    LICENSE
  }

  spec.author             = { "" => "" }
  spec.source       = { :git => "https://github.com/admiral-team/admiralui-ios.git", :tag => "#{spec.version}" }

  spec.ios.deployment_target = "14.0"
  spec.swift_version = "5.3"
  
  spec.source_files          = "Source/AdmiralSwiftUI/**/*.{h,m,swift}"
  spec.dependency "AdmiralTheme"
  spec.dependency "AdmiralUIResources"

end
