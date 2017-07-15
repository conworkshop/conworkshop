require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe '#hover_ico' do
    it 'raises when given an invalid type' do
      expect { helper.hover_ico(:woah, 'string') }.to raise_error(ArgumentError)
    end

    it 'raises when given a nil string and no block' do
      expect { helper.hover_ico(:warn, nil) }.to raise_error(ArgumentError)
    end

    it 'prefers to render a string to a block' do
      expect(helper.hover_ico(:warn, 'string') { 'block' }).to_not include('block')
    end

    it 'renders the appropriate type' do
      expect(helper.hover_ico(:warn, 'string')).to include('warn')
      expect(helper.hover_ico(:info, 'string')).to include('info')
      expect(helper.hover_ico(:dict, 'string')).to include('dict')
    end
  end

  describe '#banner' do
    it 'raises when given an invalid type' do
      expect { helper.banner(:woah, 'string') }.to raise_error(ArgumentError)
    end

    it 'raises when given a nil string and no block' do
      expect { helper.banner(:success, nil) }.to raise_error(ArgumentError)
    end

    it 'prefers to render a string to a block' do
      expect(helper.banner(:success, 'string') { 'block' }).to_not include('block')
    end

    it 'renders the appropriate type' do
      expect(helper.banner(:success, 'string')).to include('success')
      expect(helper.banner(:err, 'string')).to include('err')
      expect(helper.banner(:warn, 'string')).to include('warn')
      expect(helper.banner(:info, 'string')).to include('info')
      expect(helper.banner(:timer, 'string')).to include('timer')
    end
  end

  describe '#user_handle' do
    it 'renders the online marker' do
      expect(helper.user_handle(build(:online_user_track).user)).to include('online_mark')
    end

    it 'renders the away marker' do
      expect(helper.user_handle(build(:away_user_track).user)).to include('away_mark')
    end

    it 'renders no marker' do
      expect(helper.user_handle(build(:offline_user_track).user)).to_not include('online_mark')
    end
  end

  describe '#lang_handle' do
    subject { build(:language) }

    it 'renders a language link' do
      expect(helper.lang_handle(subject)).to include(subject.nativename)
    end

    it 'renders a language link without a flag' do
      expect(helper.lang_handle(subject, flag_thumb: false)).to_not include('flag')
    end
  end

  describe '#route_path' do
    subject { helper.route_path('static#about') }
    it { is_expected.to eq '/en/about' }
  end
end
