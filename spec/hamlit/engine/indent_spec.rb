describe Hamlit::Engine do
  describe 'tab indent' do
    it 'accepts tab indentation' do
      assert_render(<<-HAML, <<-HTML)
        %p
        \t%a
      HAML
        <p>
        <a></a>
        </p>
      HTML
    end
  end
end
