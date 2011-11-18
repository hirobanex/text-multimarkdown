use strict;
use warnings;
use utf8;
use Test::More tests => 2;

my $builder = Test::More->builder;
binmode $builder->output,         ":utf8";
binmode $builder->failure_output, ":utf8";
binmode $builder->todo_output,    ":utf8";

use_ok('Text::MultiMarkdown');

my $m = Text::MultiMarkdown->new(
    disable_definition_lists => 0
);

my $instr = <<MARKDOWN;
日本語
:   マルチバイド文字の場合はデコードされており
    正規表現の挙動がちょっと異なります。
:   日本語文字列をdecodeした状態でText::MultiMarkdownに送り込みたいです

テストコード
:   定義リストの日本語文字列のテストコードです
MARKDOWN

my $expstr = <<OUTPUT;
<dl>
<dt>日本語</dt>
<dd>
マルチバイド文字の場合はデコードされており
正規表現の挙動がちょっと異なります。
</dd>
<dd>
日本語文字列をdecodeした状態でText::MultiMarkdownに送り込みたいです
</dd>

<dt>テストコード</dt>
<dd>
定義リストの日本語文字列のテストコードです
</dd>

</dl>
OUTPUT

is($m->markdown($instr) => $expstr, 'definition lists');
