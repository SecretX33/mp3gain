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

cpp_args = []
if host_machine.system() == 'windows'
    cpp_args += ['WIN32']
endif
joined_cpp_args = ' '.join(cpp_args)

add_project_arguments('-D', joined_cpp_args, language: ['c'])

executable('mp3gain', mp3gain_sources)