require './geek.rb'
describe "bibtex" do
  it "parses bib" do
    ARGV.replace ["./rplik.txt", "./library_file.txt", "./output.txt"]
    bibparser
    expect(File.read("output.txt")).to eql('...
Informacje na ten temat znajdują się w \cite{Bailey} oraz \cite{Bay1}.
% \'author\' oraz \'journal\' to przykładowe nazwy pól z pliku BibTeX - skrypt ma działać dla dowolnych nazw pól
\begin{thebibliography}{9}
  \bibitem{Bailey}
    D. H. Bailey, P. N. Swarztrauber,
    \emph{SIAM Rev.},
    "1991"
  \bibitem{Bay1}
    A. Bayliss, C. I. Goldstein, E. Turkel,
    \emph{J. Comp. Phys.},
    "1983"
\end{thebibliography}
...')
  end
  it "parses bib example 1" do
    ARGV.replace ["./rplik1.txt", "./library_file.txt", "./output1.txt"]
    bibparser
    expect(File.read("output1.txt")).to eql('...
Informacje na ten temat znajdują się w \cite{Bailey} oraz \cite{Bay1}.
% \'author\' oraz \'title\' to przykładowe nazwy pól z pliku BibTeX - skrypt ma działać dla dowolnych nazw pól
\begin{thebibliography}{9}
  \bibitem{Bailey}
    \textbf{D. H. Bailey, P. N. Swarztrauber},
    "The fractional {F}ourier transform and applications"
  \bibitem{Bay1}
    \textbf{A. Bayliss, C. I. Goldstein, E. Turkel},
    "An iterative method for the {H}elmholtz equation"
\end{thebibliography}
...')
  end
  it "parses bib example 2" do
    ARGV.replace ["./rplik2.txt", "./library_file.txt", "./output2.txt"]
    bibparser
    expect(File.read("output2.txt")).to eql('...
Informacje na ten temat znajdują się w \cite{Bailey} oraz \cite{Bay1}.
% \'author\' oraz \'journal\' to przykładowe nazwy pól z pliku BibTeX - skrypt ma działać dla dowolnych nazw pól
\begin{thebibliography}{9}
  \bibitem{Bailey}
    D. H. Bailey, P. N. Swarztrauber,
    \emph{SIAM Rev.}
  \bibitem{Bay1}
    A. Bayliss, C. I. Goldstein, E. Turkel,
    \emph{J. Comp. Phys.}
\end{thebibliography}
...')
  end

  it "parses bib" do

  end

end