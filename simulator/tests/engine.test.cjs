const { test } = require('node:test');
const assert = require('node:assert/strict');
const { buildTrace } = require('../engine.js');
test('diamond sama dengan pola Kotlin dan mempertahankan spasi akhir', () => {
  assert.equal(
    buildTrace('diamond', 3).events.at(-1).output,
    '  *  \n *** \n*****\n *** \n  *  \n',
  );
});
test('AND/OR short circuit tidak membuat event untuk operand yang dilewati', () => {
  const trace = buildTrace('diamond', 4);
  const at = (i, j) =>
    trace.events.filter(
      (e) => e.i === i && e.j === j && e.type === 'condition',
    );
  assert.deepEqual(
    at(2, 3).map((e) => e.operand),
    ['A', 'B', 'C'],
  );
  assert.equal(at(2, 3).at(-1).values.D, 'skip');
  assert.deepEqual(
    at(5, 1).map((e) => e.operand),
    ['A', 'D', 'E'],
  );
  assert.equal(at(5, 1).at(-1).values.F, 'skip');
  assert.equal(at(5, 1)[0].values.B, 'skip');
});
test('hollow diamond mengevaluasi OR di dalam grup secara short circuit', () => {
  const trace = buildTrace('hollow-diamond', 4);
  const events = trace.events.filter(
    (e) => e.i === 2 && e.j === 3 && e.type === 'condition',
  );
  assert.deepEqual(
    events.map((e) => e.operand),
    ['A', 'B'],
  );
  assert.equal(events.at(-1).values.C, 'skip');
});
test('print dan newline terpisah, setiap condition tidak mengubah output', () => {
  const trace = buildTrace('pyramid', 3);
  let previous = '';
  let prints = 0;
  let newlines = 0;
  for (const event of trace.events) {
    if (event.type === 'print') {
      assert.equal(event.output, previous + event.char);
      prints++;
    } else if (event.type === 'newline') {
      assert.equal(event.output, previous + '\n');
      newlines++;
    } else assert.equal(event.output, previous);
    if (event.type === 'print')
      assert.equal(event.line, event.char === '*' ? 11 : 13);
    previous = event.output;
  }
  assert.equal(prints, 15);
  assert.equal(newlines, 3);
});
test('seluruh pola konsisten pada n 1..10 dan snapshot tidak berbagi map mutable', () => {
  for (const kind of ['triangle', 'pyramid', 'diamond', 'hollow-diamond'])
    for (let n = 1; n <= 10; n++) {
      const trace = buildTrace(kind, n);
      const final = trace.events.at(-1).output;
      const count = final.split('*').length - 1;
      const expected =
        kind === 'triangle'
          ? (n * (n + 1)) / 2
          : kind === 'pyramid'
            ? n * n
            : kind === 'diamond'
              ? n * n + (n - 1) ** 2
              : n === 1
                ? 1
                : 4 * n - 4;
      assert.equal(count, expected, `${kind} ${n}`);
      assert.deepEqual(trace.events[0].values, {});
      const conditions = trace.events.filter((e) => e.type === 'condition');
      if (conditions.length > 1) {
        assert.notStrictEqual(conditions[0].values, conditions.at(-1).values);
      }
      // Kondisi pertama tidak boleh terisi hasil kondisi sel terakhir.
      assert.equal(
        conditions[0].values[trace.atoms[0].key],
        kind !== 'pyramid' || n === 1,
      );
      for (const event of trace.events)
        assert.ok(event.line >= 1 && event.line <= trace.source.length);
    }
});
test('menolak ukuran di luar kontrak', () => {
  for (const n of [0, 11, 2.5, NaN])
    assert.throws(() => buildTrace('diamond', n));
});
