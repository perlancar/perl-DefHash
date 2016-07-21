package Sah::Schema::defhash;

# DATE
# VERSION

use strict;
use warnings;

our $schema = [hash => {
    summary => 'DefHash',
    keys => {

        v         => ['float', {req=>1, default=>1}, {}],

        defhash_v => ['int', {req=>1, default=>1}, {}],

        name      => ['str', {
            req=>1,
            clset => [
                {
                    match             => '\A\w+\z',
                    'match.err_level' => 'warn',
                    'match.err_msg'   => 'should be a word',
                },
                {
                    max_len             => 32,
                    'max_len.err_level' => 'warn',
                    'max_len.err_msg'   => 'should be short',
                },
            ],
            'clset.op' => 'and',
        }, {}],

        caption   => ['str', {req=>1}, {}],

        summary   => ['str', {
            req => 1,
            clset => [
                {
                    max_len             => 72,
                    'max_len.err_level' => 'warn',
                    'max_len.err_msg'   => 'should be short',
                },
                {
                    'match'           => qr/\n/,
                    'match.op'        => 'not',
                    'match.err_level' => 'warn',
                    'match.err_msg'   => 'should only be a single-line text',
                },
            ],
            'clset.op' => 'and',
        }, {}],

        description => ['str', {
            req => 1,
        }, {}],

        tags => ['array', {
            of => ['any', {
                req => 1,
                of => [
                    ['str', {req=>1}, {}],
                    ['defhash', {req=>1}, {}],
                ],
            }, {}],
        }, {}],

        default_lang => ['str', {
            req => 1,
            match => '\A[a-z]{2}(_[A-Z]{2})?\z',
        }, {}],

        x => ['any', {
        }, {}],
    },
    'keys.restrict' => 0,
    'allowed_keys_re' => '\A(\.\w+(\.\w+)*|\w+(\.\w+)*(\([a-z]{2}(_[A-Z]{2})?\))?)\z',
}, {}];

# XXX check known attributes (.alt, etc)
# XXX check alt.XXX format (e.g. must be alt\.(lang\.\w+|env_lang\.\w+)
# XXX *.alt.*.X should also be of the same type (e.g. description.alt.lang.foo

1;
# ABSTRACT:
