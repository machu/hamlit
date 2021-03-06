describe Hamlit::Engine do
  describe 'syntax error' do
    it 'raises syntax error for empty =' do
      expect { render_string('=  ') }.to raise_error(
        Hamlit::SyntaxError,
        "There's no Ruby code for = to evaluate.",
      )
    end

    it 'raises syntax error for illegal indentation' do
      expect { render_string(<<-HAML.unindent) }.
        %a
            %b
      HAML
        to raise_error(Hamlit::SyntaxError, 'inconsistent indentation: 2 spaces used for indentation, but the rest of the document was indented using 4 spaces')
    end

    it 'raises syntax error for illegal indentation' do
      expect { render_string(<<-HAML.unindent) }.
        %a
         %b
      HAML
        to raise_error(Hamlit::SyntaxError, 'inconsistent indentation: 2 spaces used for indentation, but the rest of the document was indented using 1 spaces')
    end

    it 'raises syntax error which has correct line number in backtrace' do
      begin
        render_string(<<-HAML.unindent)
          %1
            %2
            %3
            %4
          %5
            %6
            %7
             %8 this is invalid indent
          %9
        HAML
      rescue Hamlit::SyntaxError => e
        if e.respond_to?(:backtrace_locations)
          line_number = e.backtrace_locations.first.to_s.match(/:(\d+):/)[1]
          expect(line_number).to eq('8')
        end
      end
    end

    it 'raises syntax error for an inconsistent indentation' do
      expect { render_string(<<-HAML.unindent) }.
        %a
          %b
        \t\t%b
      HAML
        to raise_error(Hamlit::SyntaxError, 'Inconsistent indentation: 2 tabs used for indentation, but the rest of the document was indented using 2 spaces.')
    end
  end
end
