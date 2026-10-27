/* Mesin jejak murni: dapat dipakai browser file:// dan pengujian Node.js. */
(function (root) {
  'use strict';
  const atom = (key, text, line, test) => ({
    type: 'atom',
    key,
    text,
    line,
    test,
  });
  const and = (...children) => ({ type: 'and', children });
  const or = (...children) => ({ type: 'or', children });
  function definition(kind, n) {
    const upper = (hollow) =>
      and(
        atom('A', 'i <= n', 8, (i) => i <= n),
        hollow
          ? or(
              atom('B', 'j == n - i + 1', 8, (i, j) => j === n - i + 1),
              atom('C', 'j == n + i - 1', 8, (i, j) => j === n + i - 1),
            )
          : and(
              atom('B', 'j >= n - i + 1', 8, (i, j) => j >= n - i + 1),
              atom('C', 'j <= n + i - 1', 8, (i, j) => j <= n + i - 1),
            ),
      );
    const lower = (hollow) =>
      and(
        atom('D', 'i > n', 9, (i) => i > n),
        hollow
          ? or(
              atom('E', 'j == i - n + 1', 9, (i, j) => j === i - n + 1),
              atom('F', 'j == 3 * n - i - 1', 9, (i, j) => j === 3 * n - i - 1),
            )
          : and(
              atom('E', 'j >= i - n + 1', 9, (i, j) => j >= i - n + 1),
              atom('F', 'j <= 3 * n - i - 1', 9, (i, j) => j <= 3 * n - i - 1),
            ),
      );
    const types = {
      triangle: {
        title: 'Segitiga',
        rows: n,
        cols: n,
        outer: 'n',
        inner: 'n',
        expression: atom('A', 'j <= i', 8, (i, j) => j <= i),
        conditions: ['j <= i'],
      },
      pyramid: {
        title: 'Piramida',
        rows: n,
        cols: 2 * n - 1,
        outer: 'n',
        inner: 'size',
        expression: and(
          atom('A', 'j >= n - i + 1', 8, (i, j) => j >= n - i + 1),
          atom('B', 'j <= n + i - 1', 8, (i, j) => j <= n + i - 1),
        ),
        conditions: ['j >= n - i + 1 && j <= n + i - 1'],
      },
      diamond: {
        title: 'Diamond',
        rows: 2 * n - 1,
        cols: 2 * n - 1,
        outer: 'size',
        inner: 'size',
        expression: or(upper(false), lower(false)),
        conditions: [
          '(i <= n && j >= n - i + 1 && j <= n + i - 1) ||',
          '(i > n && j >= i - n + 1 && j <= 3 * n - i - 1)',
        ],
      },
      'hollow-diamond': {
        title: 'Hollow diamond',
        rows: 2 * n - 1,
        cols: 2 * n - 1,
        outer: 'size',
        inner: 'size',
        expression: or(upper(true), lower(true)),
        conditions: [
          '(i <= n && (j == n - i + 1 || j == n + i - 1)) ||',
          '(i > n && (j == i - n + 1 || j == 3 * n - i - 1))',
        ],
      },
    };
    const def = types[kind];
    if (!def) throw Error('Pola tidak dikenal.');
    return def;
  }
  function atoms(node) {
    return node.type === 'atom' ? [node] : node.children.flatMap(atoms);
  }
  function buildTrace(kind, n) {
    if (!Number.isInteger(n) || n < 1 || n > 10)
      throw Error('n harus bilangan bulat 1–10.');
    const def = definition(kind, n);
    const leaves = atoms(def.expression);
    // Satu kondisi tetap menempati baris 8; baris 9 sengaja kosong untuk menjaga nomor instruksi.
    const source = [
      'fun main() {',
      `    val n = ${n}`,
      '    val size = 2 * n - 1',
      '',
      `    for (i in 1..${def.outer}) {`,
      `        for (j in 1..${def.inner}) {`,
      '            if (',
      `                ${def.conditions[0]}`,
      def.conditions[1] ? `                ${def.conditions[1]}` : '',
      '            ) {',
      '                print("*")',
      '            } else {',
      '                print(" ")',
      '            }',
      '        }',
      '        println()',
      '    }',
      '}',
    ];
    const events = [];
    let output = '';
    let i = null,
      j = null;
    let values = {};
    let result = null;
    const emit = (type, line, message, extra = {}) =>
      events.push({
        type,
        line,
        message,
        i,
        j,
        n: type === 'start' ? null : n,
        size:
          ['start'].includes(type) || (type === 'assign' && line === 2)
            ? null
            : 2 * n - 1,
        values: { ...values },
        result,
        output,
        ...extra,
      });
    emit('start', 1, 'Masuk ke main().');
    emit('assign', 2, `Simpan n = ${n}.`);
    emit('assign', 3, `Hitung size = 2 × ${n} − 1 = ${2 * n - 1}.`);
    function markSkipped(node, reason) {
      for (const leaf of atoms(node)) {
        values[leaf.key] = 'skip';
      }
      return reason;
    }
    function evaluate(node) {
      if (node.type === 'atom') {
        const answer = node.test(i, j);
        values[node.key] = answer;
        emit('condition', node.line, `${node.key}: ${node.text} → ${answer}.`, {
          operand: node.key,
        });
        return answer;
      }
      for (let index = 0; index < node.children.length; index++) {
        const child = node.children[index];
        const answer = evaluate(child);
        if (
          (node.type === 'and' && !answer) ||
          (node.type === 'or' && answer)
        ) {
          const rest = node.children.slice(index + 1);
          if (rest.length) {
            rest.forEach((item) => markSkipped(item));
            // Ini anotasi event operand yang baru dievaluasi, bukan eksekusi operand yang dilewati.
            const event = events[events.length - 1];
            event.values = { ...values };
            event.message +=
              node.type === 'and'
                ? ' AND sudah false; operand berikutnya dilewati.'
                : ' OR sudah true; operand berikutnya dilewati.';
          }
          return answer;
        }
      }
      return node.type === 'and';
    }
    for (i = 1; i <= def.rows; i++) {
      j = null;
      values = {};
      result = null;
      emit('row', 5, `Loop luar memilih baris i = ${i}.`);
      for (j = 1; j <= def.cols; j++) {
        values = {};
        result = null;
        emit('cell', 6, `Loop dalam memilih kolom j = ${j}.`);
        result = evaluate(def.expression);
        emit(
          'branch',
          result ? 10 : 12,
          `Hasil if = ${result}. ${result ? 'Cabang bintang dipilih.' : 'Cabang else dipilih.'}`,
        );
        const char = result ? '*' : ' ';
        output += char;
        emit(
          'print',
          result ? 11 : 13,
          `Cetak ${result ? 'bintang (*)' : 'satu spasi'} pada console.`,
          { char },
        );
      }
      // j tidak bertambah ke cols+1 pada for Kotlin: variabel loop terakhir tetap kolom terakhir.
      j = def.cols;
      emit('inner-end', 6, 'Iterator kolom habis; keluar dari loop dalam.');
      j = null;
      output += '\n';
      emit('newline', 16, 'println() menambahkan satu karakter baris baru.');
    }
    i = def.rows;
    j = null;
    emit('outer-end', 5, 'Iterator baris habis; keluar dari loop luar.');
    emit(
      'done',
      18,
      'Program selesai. Output tetap mempertahankan spasi akhir tiap baris.',
    );
    return {
      kind,
      n,
      ...def,
      source,
      atoms: leaves.map(({ key, text }) => ({ key, text })),
      events,
    };
  }
  root.LogicEngine = { buildTrace };
  if (typeof module !== 'undefined' && module.exports)
    module.exports = root.LogicEngine;
})(typeof globalThis !== 'undefined' ? globalThis : this);
