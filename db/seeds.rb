# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def seed_if_needed(klass, check, *seeds)
  raise 'argument `klass` must inherit from ActiveRecord::Base' unless klass < ActiveRecord::Base

  seeds.each do |seed|
    name = klass.model_name.to_s
    name += %( with #{check} "#{seed[check]}") if name.present?

    ActiveRecord::Base.transaction do
      begin
        if klass.find_by("#{check}": seed[check])
          Rails.logger.info("skipped #{name} because it already exists")
        else
          klass.create!(seed)
          Rails.logger.info("created #{name}")
        end
      rescue => e
        ## ignore ##
        Rails.logger.warn("skipped #{name} because of #{e}")
      end
    end
  end
end

seed_if_needed(
  Clan,
  :name,
  { name: 'Conlanger', symbol: '✱', colour: '#009999', description: 'CWS Conlanger', permission: 'I', concrete_members: false },
  { name: 'High Council of CWS', symbol: '✱', colour: '#338833', description: 'Staff of CWS', slug: 'staff', permission: 'I' },
  { name: 'Baredan Union', symbol: '⧰', colour: '#FF7700', description: 'For the best countries only', permission: 'R' },
  {name: 'Avxyntklan', symbol: '木', colour: '#E64843', description: 'Hojdzan! Come and speak Xynder with us!', permission: 'O'}
)

seed_if_needed(
  LangType,
  :code,
  { code: 'NSP', name: 'Not specified'                          },
  { code: 'APR', name: 'A priori'                               },
  { code: 'APS', name: 'A posteriori'                           },
  { code: 'ART', name: 'Artistic Language (Artlang)'            },
  { code: 'ENG', name: 'Engineered Language (Englang)'          },
  { code: 'IAL', name: 'International Auxiliary Language (IAL)' },
  { code: 'LOG', name: 'Logical Language (Loglang)'             },
  { code: 'SGN', name: 'Signed conlang'                         },
  { code: 'PRO', name: 'Proto-Conlang'                          },
  { code: 'PID', name: 'Pidgin'                                 },
  { code: 'CRE', name: 'Creole'                                 },
  { code: 'JOK', name: 'Joke language'                          },
  { code: 'MIX', name: 'Mixed'                                  },
  code: 'OTH', name: 'Other'
)

seed_if_needed(
  Phone,
  :code,
  # Nasals (N)
  { code: 'CBNH', ipa: 'm', sampa: 'm', articulation: 'C', col: 'B', row: 'N', voiceless: false, name: 'Bilabial nasal' },
  { code: 'CLNH', ipa: 'ɱ', sampa: 'F', articulation: 'C', col: 'L', row: 'N', voiceless: false, name: 'Labio-dental nasal' },
  { code: 'CANH', ipa: 'n', sampa: 'n', articulation: 'C', col: 'A', row:'N', voiceless: false, name: 'Alveolar nasal' },
  { code: 'CRNH', ipa: 'ɳ', sampa: 'n`', articulation: 'C', col: 'R', row: 'N', voiceless: false, name: 'Retroflex nasal' },
  { code: 'CYNH', ipa: 'ȵ', articulation: 'C', col: 'Y', row: 'N', voiceless: false, name: 'Alveo-palatal nasal' },
  { code: 'CJNH', ipa: 'ɲ', sampa: 'J', articulation: 'C', col: 'J', row: 'N', voiceless: false, name: 'Palatal nasal' },
  { code: 'CVNH', ipa: 'ŋ', sampa: 'N', articulation: 'C', col: 'V', row: 'N', voiceless: false, name: 'Velar nasal' },
  { code: 'CUNH', ipa: 'ɴ', sampa: 'N\\', articulation: 'C', col: 'U', row: 'N', voiceless: false, name: 'Uvular nasal' },
  # Plosives (P)
  { code: 'CBP', ipa: 'p', sampa: 'p', articulation: 'C', col: 'B', row: 'P', voiceless: true, name: 'Voiceless bilabial stop' },
  { code: 'CBPH', ipa: 'b', sampa: 'b', articulation: 'C', col: 'B', row: 'P', voiceless: false, name: 'Voiced bilabial stop' },
  { code: 'CAP', ipa: 't', sampa: 't', articulation: 'C', col: 'A', row: 'P', voiceless: true, name: 'Voiceless alveolar stop' },
  { code: 'CAPH', ipa: 'd', sampa: 'd', articulation: 'C', col: 'A', row: 'P', voiceless: false, name: 'Voiced alveolar stop' },
  { code: 'CRP', ipa: 'ʈ', sampa: 't`', articulation: 'C', col: 'R', row: 'P', voiceless: true, name: 'Voiceless retroflex stop' },
  { code: 'CRPH', ipa: 'ɖ', sampa: 'd`', articulation: 'C', col: 'R', row: 'P', voiceless: false, name: 'Voiced retroflex stop' },
  { code: 'CYP', ipa: 'ȶ', articulation: 'C', col: 'Y', row: 'P', voiceless: true, name: 'Voiceless alveo-palatal stop' },
  { code: 'CYPH', ipa: 'ȡ', articulation: 'C', col: 'Y', row: 'P', voiceless: false, name: 'Voiced alveo-palatal stop' },
  { code: 'CJP', ipa: 'c', sampa: 'c', articulation: 'C', col: 'J', row: 'P', voiceless: true, name: 'Voiceless palatal stop' },
  { code: 'CJPH', ipa: 'ɟ', sampa: 'J\\', articulation: 'C', col: 'J', row: 'P', voiceless: false, name: 'Voiced palatal stop' },
  { code: 'CVP', ipa: 'k', sampa: 'k', articulation: 'C', col: 'V', row: 'P', voiceless: true, name: 'Voiceless velar stop' },
  { code: 'CVPH', ipa: 'g', sampa: 'g', articulation: 'C', col: 'V', row: 'P', voiceless: false, name: 'Voiced velar stop' },
  { code: 'CUP', ipa: 'q', sampa: 'q', articulation: 'C', col: 'U', row: 'P', voiceless: true, name: 'Voiceless uvular stop' },
  { code: 'CUPH', ipa: 'ɢ', sampa: 'G\\', articulation: 'C', col: 'U', row: 'P', voiceless: false, name: 'Voiced uvular stop' },
  { code: 'CXP', ipa: 'ʡ', sampa: '>\\', articulation: 'C', col: 'X', row: 'P', voiceless: true, name: 'Epiglottal stop' },
  { code: 'CGP', ipa: 'ʔ', sampa: '?', articulation: 'C', col: 'G', row: 'P', voiceless: true, name: 'Glottal stop' },
  # Implosives (I)
  { code: 'CBIH', ipa:'ɓ', sampa: 'b_<', articulation: 'C', col: 'B', row: 'I', voiceless: false, name: 'Voiced bilabial implosive' },
  { code: 'CAIH', ipa: 'ɗ', sampa: 'd_<', articulation: 'C', col: 'A', row: 'I', voiceless: false, name: 'Voiced alveolar implosive' },
  { code: 'CRIH', ipa: 'ᶑ', sampa: 'd`_<', articulation: 'C', col: 'R', row: 'I', voiceless: false, name: 'Voiced retroflex implosive' },
  { code: 'CJIH', ipa: 'ʄ', sampa: 'J\\_<', articulation: 'C', col: 'J', row: 'I', voiceless: false, name: 'Voiced palatal implosive' },
  { code: 'CVIH', ipa: 'ɠ', sampa: 'g_<', articulation: 'C', col: 'V', row: 'I', voiceless: false, name: 'Voiced velar implosive' },
  { code: 'CUIH', ipa: 'ʛ', sampa: 'G\\_<', articulation: 'C', col: 'U', row: 'I', voiceless: false, name: 'Voiced uvular implosive' },
  # Affricates (J)
  { code: 'CBJ', ipa: 'p͡ɸ', sampa: 'pp\\', articulation: 'C', col: 'B', row: 'J', voiceless: true, name: 'Voiceless bilabial affricate' },
  { code: 'CBJH', ipa: 'b͡β', sampa: 'bB', articulation: 'C', col: 'B', row: 'J', voiceless: false, name: 'Voiced bilabial affricate' },
  { code: 'CLJ', ipa: 'p͡f', sampa: 'pf', articulation: 'C', col: 'L', row: 'J', voiceless: true, name: 'Voiceless labio-dental affricate' },
  { code: 'CLJH', ipa: 'b͡v', sampa: 'bv', articulation: 'C', col: 'L', row: 'J', voiceless: false, name: 'Voiced labio-dental affricate' },
  { code: 'CDJ', ipa: 't͡θ', sampa: 'tT', articulation: 'C', col: 'D', row: 'J', voiceless: true, name: 'Voiceless dental affricate' },
  { code: 'CDJH', ipa: 'd͡ð', sampa: 'dD', articulation: 'C', col: 'D', row: 'J', voiceless: false, name: 'Voiced dental affricate' },
  { code: 'CAJ', ipa: 't͡s', sampa: 'ts', articulation: 'C', col: 'A', row: 'J', voiceless: true, name: 'Voiceless alveolar affricate' },
  { code: 'CAJH', ipa: 'd͡z', sampa: 'dz', articulation: 'C', col: 'A', row: 'J', voiceless: false, name: 'Voiced alveolar affricate' },
  { code: 'CPJ', ipa: 't͡ʃ', sampa: 'tS', articulation: 'C', col: 'P', row: 'J', voiceless: true, name: 'Voiceless post-alveolar affricate' },
  { code: 'CPJH', ipa: 'd͡ʒ', sampa: 'dZ', articulation: 'C', col: 'P', row: 'J', voiceless: false, name: 'Voiced post-alveolar affricate' },
  { code: 'CRJ', ipa: 't͡ʂ', sampa: 'ts`', articulation: 'C', col: 'R', row: 'J', voiceless: true, name: 'Voiceless retroflex affricate' },
  { code: 'CRJH', ipa: 'd͡ʐ', sampa: 'dz`', articulation: 'C', col: 'R', row: 'J', voiceless: false, name: 'Voiced retroflex affricate' },
  { code: 'CYJ', ipa: 't͡ɕ', sampa: 'ts\\', articulation: 'C', col: 'Y', row: 'J', voiceless: true, name: 'Voiceless alveo-palatal affricate' },
  { code: 'CYJH', ipa: 'd͡ʑ', sampa: 'dz\\', articulation: 'C', col: 'Y', row: 'J', voiceless: false, name: 'Voiced alveo-palatal affricate' },
  { code: 'CJJ', ipa: 'c͡ç', sampa: 'cC', articulation: 'C', col: 'J', row: 'J', voiceless: true, name: 'Voiceless palatal affricate' },
  { code: 'CJJH', ipa: 'ɟ͡ʝ', sampa: 'J\\j\\', articulation: 'C', col: 'J', row: 'J', voiceless: false, name: 'Voiced palatal affricate' },
  { code: 'CVJ', ipa: 'k͡x', sampa: 'kx', articulation: 'C', col: 'V', row: 'J', voiceless: true, name: 'Voiceless velar affricate' },
  { code: 'CVJH', ipa: 'g͡ɣ', sampa: 'gG', articulation: 'C', col: 'V', row: 'J', voiceless: false, name: 'Voiced velar affricate' },
  { code: 'CUJ', ipa: 'q͡χ', sampa: 'qX', articulation: 'C', col: 'U', row: 'J', voiceless: true, name: 'Voiceless uvular affricate' },
  { code: 'CUJH', ipa: 'ɢ͡ʁ', sampa: 'G\\R', articulation: 'C', col: 'U', row: 'J', voiceless: false, name: 'Voiced uvular affricate' },
  { code: 'CXJH', ipa: 'ʡ͡ʢ', sampa: '>\\<\\', articulation: 'C', col: 'X', row: 'J', voiceless: false, name: 'Voiced epiglottal affricate' },
  { code: 'CGJ', ipa: 'ʔ͡h', sampa: '?h', articulation: 'C', col: 'G', row: 'J', voiceless: true, name: 'Voiceless glottal affricate' },
  # Lateral affricates (Q)
  { code: 'CAQ', ipa: 't͡ɬ', sampa: 'tK', articulation: 'C', col: 'A', row: 'Q', voiceless: true, name: 'Voiceless alveolar lateral affricate' },
  { code: 'CAQH', ipa: 'd͡ɮ', sampa: 'dK\\', articulation: 'C', col: 'A', row: 'Q', voiceless: false, name: 'Voiced alveolar lateral affricate' },
  { code: 'CRQ', ipa: 't͡ꞎ', sampa: 'tK`', articulation: 'C', col: 'R', row: 'Q', voiceless: true, name: 'Voiceless retroflex lateral affricate' },
  { code: 'CRQH', ipa: 'd͡ɭ˔', sampa: 'dl`_r', articulation: 'C', col: 'R', row: 'Q', voiceless: false, name: 'Voiced retroflex lateral affricate' },
  { code: 'CJQ', ipa: 'c͡ʎ̥˔', sampa: 'cL_0_r', articulation: 'C', col: 'J', row: 'Q', voiceless: true, name: 'Voiceless palatal lateral affricate' },
  { code: 'CJQH', ipa: 'ɟ͡ʎ˔', sampa: 'J\\L_r', articulation: 'C', col: 'J', row: 'Q', voiceless: false, name: 'Voiced palatal lateral affricate' },
  { code: 'CVQ', ipa: 'k͡ʟ̝̊', sampa: 'kL\\_0_r', articulation: 'C', col: 'V', row: 'Q', voiceless: true, name: 'Voiceless velar lateral affricate' },
  { code: 'CVQH', ipa: 'g͡ʟ̝', sampa: 'gL\\_r', articulation: 'C', col: 'V', row: 'Q', voiceless: false, name: 'Voiced velar lateral affricate' },
  { code: 'CUQ', ipa: 'q͡ʟ̝̠̊', sampa: 'kL\\_0_r_-', articulation: 'C', col: 'U', row: 'Q', voiceless: true, name: 'Voiceless uvular lateral affricate' },
  { code: 'CUQH', ipa: 'ɢ͡ʟ̝̠', sampa: 'G\\L\\_r_-', articulation: 'C', col: 'U', row: 'Q', voiceless: false, name: 'Voiced uvular lateral affricate' },
  # Fricatives (F)
  { code: 'CBF', ipa: 'ɸ', sampa: 'p\\', articulation: 'C', col: 'B', row: 'F', voiceless: true, name: 'Voiceless bilabial fricative' },
  { code: 'CBFH', ipa: 'β', sampa: 'B', articulation: 'C', col: 'B', row: 'F', voiceless: false, name: 'Voiced bilabial fricative' },
  { code: 'CLF', ipa: 'f', sampa: 'f', articulation: 'C', col: 'L', row: 'F', voiceless: true, name: 'Voiceless labiodental fricative' },
  { code: 'CLFH', ipa: 'v', sampa: 'v', articulation: 'C', col: 'L', row: 'F', voiceless: false, name: 'Voiced labiodental fricative' },
  { code: 'CDF', ipa: 'θ', sampa: 'T', articulation: 'C', col: 'D', row: 'F', voiceless: true, name: 'Voiceless dental fricative' },
  { code: 'CDFH', ipa: 'ð', sampa: 'D', articulation: 'C', col: 'D', row: 'F', voiceless: false, name: 'Voiced dental fricative' },
  { code: 'CAF', ipa: 's', sampa: 's', articulation: 'C', col: 'A', row: 'F', voiceless: true, name: 'Voiceless alveolar fricative' },
  { code: 'CAFH', ipa: 'z', sampa: 'z', articulation: 'C', col: 'A', row: 'F', voiceless: false, name: 'Voiced alveolar fricative' },
  { code: 'CPF', ipa: 'ʃ', sampa: 'S', articulation: 'C', col: 'P', row: 'F', voiceless: true, name: 'Voiceless post-alveolar fricative' },
  { code: 'CPFH', ipa: 'ʒ', sampa: 'Z', articulation: 'C', col: 'P', row: 'F', voiceless: false, name: 'Voiced post-alveolar fricative' },
  { code: 'CRF', ipa: 'ʂ', sampa: 's`', articulation: 'C', col: 'R', row: 'F', voiceless: true, name: 'Voiceless retroflex fricative' },
  { code: 'CRFH', ipa: 'ʐ', sampa: 'z`', articulation: 'C', col: 'R', row: 'F', voiceless: false, name: 'Voiced retroflex fricative' },
  { code: 'CYF', ipa: 'ɕ', sampa: 's\\', articulation: 'C', col: 'Y', row: 'F', voiceless: true, name: 'Voiceless alveo-palatal fricative' },
  { code: 'CYFH', ipa: 'ʑ', sampa: 'z\\', articulation: 'C', col: 'Y', row: 'F', voiceless: false, name: 'Voiced alveo-palatal fricative' },
  { code: 'CJPF', ipa: 'ç', sampa: 'C', articulation: 'C', col: 'J', row: 'F', voiceless: true, name: 'Voiceless palatal fricative' },
  { code: 'CJFH', ipa: 'ʝ', sampa: 'j\\', articulation: 'C', col: 'J', row: 'F', voiceless: false, name: 'Voiced palatal fricative' },
  { code: 'CVF', ipa: 'x', sampa: 'x', articulation: 'C', col: 'V', row: 'F', voiceless: true, name: 'Voiceless velar fricative' },
  { code: 'CVFH', ipa: 'ɣ', sampa: 'G', articulation: 'C', col: 'V', row: 'F', voiceless: false, name: 'Voiced velar fricative' },
  { code: 'CUF', ipa: 'χ', sampa: 'X', articulation: 'C', col: 'U', row: 'F', voiceless: true, name: 'Voiceless uvular fricative' },
  { code: 'CUFH', ipa: 'ʁ', sampa: 'R', articulation: 'C', col: 'U', row: 'F', voiceless: false, name: 'Voiced uvular fricative' },
  { code: 'CHF', ipa: 'ħ', sampa: 'X\\', articulation: 'C', col: 'H', row: 'F', voiceless: true, name: 'Voiceless pharyngeal fricative' },
  { code: 'CHFH', ipa: 'ʕ', sampa: '?\\', articulation: 'C', col: 'H', row: 'F', voiceless: false, name: 'Voiced pharyngeal fricative' },
  { code: 'CXF', ipa: 'ʜ', sampa: 'H\\', articulation: 'C', col: 'X', row: 'F', voiceless: true, name: 'Voiceless epiglottal fricative' },
  { code: 'CXFH', ipa: 'ʢ', sampa: '<\\', articulation: 'C', col: 'X', row: 'F', voiceless: false, name: 'Voiced epiglottal fricative' },
  { code: 'CGF', ipa: 'h', sampa: 'h', articulation: 'C', col: 'G', row: 'F', voiceless: true, name: 'Voiceless glottal fricative' },
  { code: 'CGFH', ipa: 'ɦ', sampa: 'h\\', articulation: 'C', col: 'G', row: 'F', voiceless: false, name: 'Voiced glottal fricative' },
  # Lateral fricatives (Z)
  { code: 'CAZ', ipa: 'ɬ', sampa: 'K', articulation: 'C', col: 'A', row: 'Z', voiceless: true, name: 'Voiceless alveolar lateral fricative' },
  { code: 'CAZH', ipa: 'ɮ', sampa: 'K\\', articulation: 'C', col: 'A', row: 'Z', voiceless: false, name: 'Voiced alveolar lateral fricative' },
  { code: 'CRZ', ipa: 'ꞎ', sampa: 'l`_0_r', articulation: 'C', col: 'R', row: 'Z', voiceless: true, name: 'Voiceless retroflex lateral fricative' },
  # Taps (X)
  { code: 'CLXH', ipa: 'ⱱ', sampa: 'v`', articulation: 'C', col: 'L', row: 'X', voiceless: false, name: 'Labio-dental tap' },
  { code: 'CAXH', ipa: 'ɾ', sampa: '4', articulation: 'C', col: 'A', row: 'X', voiceless: false, name: 'Alveolar tap' },
  { code: 'CRXH', ipa: 'ɽ', sampa: 'r`', articulation: 'C', col: 'R', row: 'X', voiceless: false, name: 'Retroflex tap' },
  # Lateral flaps (R)
  { code: 'CARH', ipa: 'ɺ', sampa: 'l\\', articulation: 'C', col: 'A', row: 'R', voiceless: false, name: 'Alveolar lateral flap' },
  # Trills (T)
  { code: 'CBTH', ipa: 'ʙ', sampa: 'B\\', articulation: 'C', col: 'B', row: 'T', voiceless: false, name: 'Bilabial trill' },
  { code: 'CATH', ipa: 'r', sampa: 'r', articulation: 'C', col: 'A', row: 'T', voiceless: false, name: 'Alveolar trill' },
  { code: 'CRTH', ipa: 'ɽ͡r', sampa: 'r`r', articulation: 'C', col: 'R', row: 'T', voiceless: false, name: 'Retroflex trill' },
  { code: 'CUTH', ipa: 'ʀ', sampa: 'R\\', articulation: 'C', col: 'U', row: 'T', voiceless: false, name: 'Uvular trill' },
  # Lateral approximants (L)
  { code: 'CALH', ipa: 'l', sampa: 'l', articulation: 'C', col: 'A', row: 'L', voiceless: false, name: 'Alveolar lateral approximant' },
  { code: 'CRLH', ipa: 'ɭ', sampa: 'l`', articulation: 'C', col: 'R', row: 'L', voiceless: false, name: 'Retroflex lateral approximant' },
  { code: 'CYLH', ipa: 'ȴ', sampa: 'L_+', articulation: 'C', col: 'Y', row: 'L', voiceless: false, name: 'Alveo-palatal lateral approximant' },
  { code: 'CJLH', ipa: 'ʎ', sampa: 'L', articulation: 'C', col: 'J', row: 'L', voiceless: false, name: 'Palatal lateral approximant' },
  { code: 'CVLH', ipa: 'ʟ', sampa: 'L\\', articulation: 'C', col: 'V', row: 'L', voiceless: false, name: 'Velar lateral approximant' },
  # Approximants (A)
  { code: 'CLAH', ipa: 'ʋ', sampa: 'P', articulation: 'C', col: 'L', row: 'A', voiceless: false, name: 'Labio-dental approximant' },
  { code: 'CAAH', ipa: 'ɹ', sampa: 'r\\', articulation: 'C', col: 'A', row: 'A', voiceless: false, name: 'Alveolar approximant' },
  { code: 'CRAH', ipa: 'ɻ', sampa: 'r\\`', articulation: 'C', col: 'R', row: 'A', voiceless: false, name: 'Retroflex approximant' },
  { code: 'CJAH', ipa: 'j', sampa: 'j', articulation: 'C', col: 'J', row: 'A', voiceless: false, name: 'Palatal approximant' },
  { code: 'CWA', ipa: 'ʍ', sampa: 'W', articulation: 'C', col: 'B', row: 'A', voiceless: true, name: 'Voiceless labio-velar approximant' },
  { code: 'CWAH', ipa: 'w', sampa: 'w', articulation: 'C', col: 'B', row: 'A', voiceless: false, name: 'Voiced labio-velar approximant' },
  { code: 'CVAH', ipa: 'ɰ', sampa: 'M\\', articulation: 'C', col: 'V', row: 'A', voiceless: false, name: 'Velar approximant' },
  # Clicks (C)
  { code: 'CBC', ipa: 'ʘ', sampa: 'O\\', articulation: 'C', col: 'B', row: 'C', voiceless: true, name: 'Bilabial click' },
  { code: 'CDC', ipa: 'ǀ', sampa: '|\\', articulation: 'C', col: 'D', row: 'C', voiceless: true, name: 'Dental click' },
  { code: 'CAC', ipa: 'ǃ', sampa: '!\\', articulation: 'C', col: 'A', row: 'C', voiceless: true, name: 'Alveolar click' },
  { code: 'CRC', ipa: '‼', sampa: '!\\`', articulation: 'C', col: 'R', row: 'C', voiceless: true, name: 'Retroflex click' },
  { code: 'CJC', ipa: 'ǂ', sampa: '=\\', articulation: 'C', col: 'J', row: 'C', voiceless: true, name: 'Palatal click' },
  { code: 'CVC', ipa: 'ʞ', articulation: 'C', col: 'V', row: 'C', voiceless: true, name: 'Velar click' },
  # Lateral clicks (K)
  { code: 'CAK', ipa: 'ǁ', sampa: '|\\|\\', articulation: 'C', col: 'A', row: 'K', voiceless: true, name: 'Lateral click' },
  # VOWELS -- high (C)
  { code: 'VCF', ipa: 'i', sampa: 'i', articulation: 'V', col: 'F', row: 'C', rounded: false, name: 'High front unrounded vowel' },
  { code: 'VCFR', ipa: 'y', sampa: 'y', articulation: 'V', col: 'F', row: 'C', rounded: true, name: 'High front rounded vowel' },
  { code: 'VCC', ipa: 'ɨ', sampa: 'ɨ', articulation: 'V', col: 'C', row: 'C', rounded: false, name: 'High central unrounded vowel' },
  { code: 'VCCR', ipa: 'ʉ', sampa: '}', articulation: 'V', col: 'C', row: 'C', rounded: true, name: 'High central rounded vowel' },
  { code: 'VCB', ipa: 'ɯ', sampa: 'M', articulation: 'V', col: 'B', row: 'C', rounded: false, name: 'High back unrounded vowel' },
  { code: 'VCBR', ipa: 'u', sampa: 'u', articulation: 'V', col: 'B', row: 'C', rounded: true, name: 'High back rounded vowel' },
  # Near-high (N)
  { code: 'VNN', ipa: 'ɪ', sampa: 'I', articulation: 'V', col: 'N', row: 'N', rounded: false, name: 'Near-high near-front unrounded vowel' },
  { code: 'VNNR', ipa: 'ʏ', sampa: 'Y', articulation: 'V', col: 'N', row: 'N', rounded: true, name: 'Near-high near-front rounded vowel' },
  { code: 'VNKR', ipa: 'ʊ', sampa: 'U', articulation: 'V', col: 'K', row: 'N', rounded: true, name: 'Near-high near-back rounded vowel' },
  # High-mid (L)
  { code: 'VLF', ipa: 'e', sampa: 'e', articulation: 'V', col: 'F', row: 'L', rounded: false, name: 'High-mid front unrounded vowel' },
  { code: 'VLFR', ipa: 'ø', sampa: '2', articulation: 'V', col: 'F', row: 'L', rounded: true, name: 'High-mid front rounded vowel' },
  { code: 'VLC', ipa: 'ɘ', sampa: '@\\', articulation: 'V', col: 'C', row: 'L', rounded: false, name: 'High-mid central unrounded vowel' },
  { code: 'VLCR', ipa: 'ɵ', sampa: '8', articulation: 'V', col: 'C', row: 'L', rounded: true, name: 'High-mid central rounded vowel' },
  { code: 'VLB', ipa: 'ɤ', sampa: '7', articulation: 'V', col: 'B', row: 'L', rounded: false, name: 'High-mid back unrounded vowel' },
  { code: 'VLBR', ipa: 'o', sampa: 'o', articulation: 'V', col: 'B', row: 'L', rounded: true, name: 'High-mid back rounded vowel' },
  # Mid (M)
  { code: 'VMC', ipa: 'ə', sampa: '@', articulation: 'V', col: 'C', row: 'M', rounded: false, name: 'Schwa (mid central unrounded vowel)' },
  # Low-mid (I)
  { code: 'VIF', ipa: 'ɛ', sampa: 'E', articulation: 'V', col: 'F', row: 'I', rounded: false, name: 'Low-mid front unrounded vowel' },
  { code: 'VIFR', ipa: 'œ', sampa: '9', articulation: 'V', col: 'F', row: 'I', rounded: true, name: 'Low-mid front rounded vowel' },
  { code: 'VIC', ipa: 'ɜ', sampa: '3', articulation: 'V', col: 'C', row: 'I', rounded: false, name: 'Low-mid central unrounded vowel' },
  { code: 'VICR', ipa: 'ɞ', sampa: '3\\', articulation: 'V', col: 'C', row: 'I', rounded: true, name: 'Low-mid central rounded vowel' },
  { code: 'VIB', ipa: 'ʌ', sampa: 'V', articulation: 'V', col: 'B', row: 'I', rounded: false, name: 'Low-mid back unrounded vowel' },
  { code: 'VIBR', ipa: 'ɔ', sampa: 'O', articulation: 'V', col: 'B', row: 'I', rounded: true, name: 'Low-mid back rounded vowel' },
  # Near-low (P)
  { code: 'VPC', ipa: 'ɐ', sampa: '6', articulation: 'V', col: 'C', row: 'P', rounded: false, name: 'Near-low central unrounded vowel' },
  # Low (O)
  { code: 'VOF', ipa: 'æ', sampa: '{', articulation: 'V', col: 'F', row: 'O', rounded: false, name: 'Low front unrounded vowel' },
  { code: 'VOFR', ipa: 'ɶ', sampa: '&', articulation: 'V', col: 'F', row: 'O', rounded: true, name: 'Low front rounded vowel' },
  { code: 'VOC', ipa: 'a', sampa: 'a', articulation: 'V', col: 'C', row: 'O', rounded: false, name: 'Low central unrounded vowel' },
  { code: 'VOB', ipa: 'ɑ', sampa: 'A', articulation: 'V', col: 'B', row: 'O', rounded: false, name: 'Low back unrounded vowel' },
  { code: 'VOBR', ipa: 'ɒ', sampa: 'Q', articulation: 'V', col: 'B', row: 'O', rounded: true, name: 'Low back rounded vowel' }
)

#more soon, diacritics are also useful for phonology modifiers like in the old CWS
# these are from the wikipedia page, names equal to the old CWS where they coincide (in case we want to import the languages)
# to-do: add all the rest from the original website such as labio-palatized. may need to come up with fake X-sampa
seed_if_needed(
  Diacritic,
  :name,

  {sampa: '"', ipa: 'ˈ', name:'Primary stress', modifier:false},
  {sampa: '%', ipa: 'ˌ', name:'Secondary stress', modifier:false},
  {sampa: ':', ipa: 'ː', name:'Long', modifier:true},
  {sampa: ':\\', ipa: 'ˑ', name:'Half-long', modifier:true},
  {sampa: '_"', ipa: '̈', name:'Centralised', modifier:true},
  {sampa: '_+', ipa: '̟', name:'Advanced', modifier:true},
  {sampa: '_-', ipa: '̠', name:'Retracted', modifier:true},
  {sampa: '_/', ipa: '̌', name:'Tone - Rising', modifier:true},
  {sampa: '_0', ipa: '̥', name:'Voiceless', modifier:true},
  {sampa: '_=', ipa: '̩', name:'Syllabic', modifier:true},
  {sampa: '_>', ipa: 'ʼ', name:'Ejective', modifier:true},
  {sampa: '_?\\', ipa: 'ˤ', name:'Pharyngealised', modifier:true},
  {sampa: '_\\', ipa: '̂', name:'Tone - Falling', modifier:true},
  {sampa: '_^', ipa: '̯', name:'Non-syllabic', modifier:true},
  {sampa: '_}', ipa: '̚', name:'No audible release', modifier:true},
  {sampa: '`', ipa: '˞', name:'Rhotacised', modifier:true},
  {sampa: '_~', ipa: '̃', name:'Nasalised', modifier:true},
  {sampa: '_A', ipa: '̘', name:'Advanced tongue root', modifier:true},
  {sampa: '_a', ipa: '̺', name:'Apical', modifier:true},
  {sampa: '_B', ipa: '̏', name:'Tone - Extra low', modifier:true},
  {sampa: '_B_L', ipa: '᷅', name:'Tone - Low rising', modifier:true},
  {sampa: '_c', ipa: '̜', name:'Less rounded', modifier:true},
  {sampa: '_d', ipa: '̪', name:'Dental', modifier:true},
  {sampa: '_e', ipa: '̴', name:'Velopharyngeal', modifier:true},
  {sampa: '<F>', ipa: '↘', name:'Global fall', modifier:false},
  {sampa: '_F', ipa: '̂', name:'Tone -  Falling', modifier:true},
  {sampa: '_G', ipa: 'ˠ', name:'Velarized', modifier:true},
  {sampa: '_H', ipa: '́', name:'Tone - High', modifier:true},
  {sampa: '_H_T', ipa: '᷄', name:'Tone - High rising', modifier:true},
  {sampa: '_h', ipa: 'ʰ', name:'Aspirated', modifier:true},
  {sampa: "'", ipa: 'ʲ', name:'Palatalised', modifier:true},
  {sampa: '_k', ipa: '̰', name:'Creaky voiced', modifier:true},
  {sampa: '_L', ipa: '̀', name:'Tone - Low', modifier:true},
  {sampa: '_l', ipa: 'ˡ', name:'Lateral release', modifier:true},
  {sampa: '_M', ipa: '̄', name:'Tone - Mid', modifier:true},
  {sampa: '_m', ipa: '̻', name:'Laminal', modifier:true},
  {sampa: '_N', ipa: '̼', name:'Linguolabial', modifier:true},
  {sampa: '_n', ipa: 'ⁿ', name:'Nasal release', modifier:true},
  {sampa: '_O', ipa: '̹', name:'More rounded', modifier:true},
  {sampa: '_o', ipa: '̞', name:'Lowered', modifier:true},
  {sampa: '_q', ipa: '̙', name:'Retracted tongue root', modifier:true},
  {sampa: '<R>', ipa: '↗', name:'Global rise', modifier:false},
  {sampa: '_R', ipa: '̌', name:'Tone - Rising', modifier:true},
  {sampa: '_R_F', ipa: '᷈', name:'Tone - Rising Falling', modifier:true},
  {sampa: '_r', ipa: '̝', name:'Raised', modifier:true},
  {sampa: '_T', ipa: '̋', name:'Tone - Extra high', modifier:true},
  {sampa: '_t', ipa: '̤', name:'Breathy voiced', modifier:true},
  {sampa: '_v', ipa: '̬', name:'Voiced', modifier:true},
  {sampa: '_w', ipa: 'ʷ', name:'Labialised', modifier:true},
  {sampa: '_X', ipa: '̆', name:'Short consonant', modifier:true},
  {sampa: '_x', ipa: '̽', name:'Mid-centralised', modifier:true},


  {sampa: '-\\', ipa: '‿', name:'Linking mark', modifier:false}
)
