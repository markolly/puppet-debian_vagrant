# frozen_string_literal: true

require 'spec_helper'
describe 'debian_vagrant::base' do
  let(:facts) do
    {
      kernel: 'Linux',
      operatingsystem: 'Debian',
      operatingsystemmajrelease: '9',
      operatingsystemrelease: '9',
      osfamily: 'Debian'
    }
  end
  it { should contain_class('debian_vagrant::base') }
  it { should compile }
  it do
    should contain_exec('apt update')
      .with(
        command: 'apt update'
      )
  end
  it do
    should contain_exec('update timezone')
      .with(
        command: 'dpkg-reconfigure -f noninteractive tzdata'
      )
  end
  it do
    should contain_file('/etc/timezone')
      .with(
        content: 'Europe/London',
        notify: 'Exec[update timezone]'
      )
  end
  %w[htop tree unzip vim].each do |x|
    it {
      should contain_package(x)
        .with(ensure: 'present')
    }
  end
end
