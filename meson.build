project('mp3gain', 'c', default_options: [
    'warning_level=0'
])

mp3gain_sources = [
    'mp3gain.c',
    'apetag.c',
    'gain_analysis.c',
    'id3tag.c',
    'rg_error.c',
]

if host_machine.system() == 'windows'
    add_project_arguments('-D', 'WIN32', language: ['c'])
endif

executable('mp3gain', mp3gain_sources)