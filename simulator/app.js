(function () {
  'use strict';
  const $ = (id) => document.getElementById(id);
  let trace,
    cursor = 0,
    revealed = true;
  function setup() {
    const n = Number($('n').value);
    try {
      trace = LogicEngine.buildTrace($('pattern').value, n);
    } catch (error) {
      $('config-error').textContent = error.message;
      return;
    }
    $('config-error').textContent = '';
    cursor = 0;
    revealed = !$('practice').checked;
    $('answer').value = '';
    $('answer-result').textContent = '';
    render();
  }
  function render() {
    const event = trace.events[cursor];
    $('challenge').hidden = !$('practice').checked;
    $('reveal').hidden = !$('practice').checked || revealed;
    $('source').closest('.panel').classList.toggle('masked', !revealed);
    $('source').replaceChildren();
    if (!revealed)
      $('source').textContent =
        'Coba prediksi pola dahulu. Klik “Lihat solusi” untuk membuka.';
    else
      trace.source.forEach((line, index) => {
        const row = document.createElement('div');
        row.className =
          'code-line' + (index + 1 === event.line ? ' current' : '');
        if (index + 1 === event.line) row.setAttribute('aria-current', 'step');
        const number = document.createElement('span');
        number.className = 'line-no';
        number.textContent = index + 1;
        const code = document.createElement('code');
        code.textContent = line;
        row.append(number, code);
        $('source').append(row);
      });
    $('grid-size').textContent = `${trace.rows} × ${trace.cols}`;
    const grid = $('grid');
    grid.replaceChildren();
    grid.style.gridTemplateColumns = `repeat(${trace.cols + 1}, auto)`;
    const printed = new Map();
    for (let k = 0; k <= cursor; k++) {
      const e = trace.events[k];
      if (e.type === 'print') printed.set(`${e.i},${e.j}`, e.char);
    }
    for (let i = 0; i <= trace.rows; i++)
      for (let j = 0; j <= trace.cols; j++) {
        const cell = document.createElement('div');
        cell.className = 'cell';
        if (i === 0 || j === 0) {
          cell.classList.add('label');
          cell.textContent = i === 0 ? (j === 0 ? 'i / j' : j) : i;
        } else {
          cell.setAttribute('role', 'gridcell');
          cell.setAttribute('aria-label', `baris ${i}, kolom ${j}`);
          if (revealed && printed.has(`${i},${j}`)) {
            const char = printed.get(`${i},${j}`);
            cell.textContent = char === '*' ? '*' : '·';
            if (char === '*') cell.classList.add('printed');
          }
          if (
            event.i === i &&
            event.j === j &&
            ['cell', 'condition', 'branch', 'print'].includes(event.type)
          )
            cell.classList.add('current');
        }
        grid.append(cell);
      }
    $('variables').replaceChildren();
    for (const [key, value] of Object.entries({
      n: event.n,
      size: event.size,
      i: event.i,
      j: event.j,
    })) {
      const item = document.createElement('div');
      item.className = 'variable';
      const label = document.createElement('span');
      label.textContent = key;
      const val = document.createElement('strong');
      val.textContent = value ?? '—';
      item.append(label, val);
      $('variables').append(item);
    }
    const names = {
      start: 'mulai',
      assign: 'variabel',
      row: 'baris',
      cell: 'kolom',
      condition: 'evaluasi',
      branch: 'pilih cabang',
      print: 'print()',
      newline: 'println()',
      'inner-end': 'akhir kolom',
      'outer-end': 'akhir baris',
      done: 'selesai',
    };
    $('event-type').textContent = names[event.type];
    $('conditions').replaceChildren();
    if (!revealed)
      $('conditions').textContent = 'Kondisi disembunyikan selama latihan.';
    else
      for (const { key, text } of trace.atoms) {
        const row = document.createElement('div');
        row.className = 'condition';
        const label = document.createElement('code');
        label.textContent = `${key} · ${text}`;
        const value = event.values[key];
        const badge = document.createElement('span');
        badge.className =
          'badge ' +
          (value === true
            ? 'true'
            : value === false
              ? 'false'
              : value === 'skip'
                ? 'skip'
                : '');
        badge.textContent =
          value === true
            ? 'true'
            : value === false
              ? 'false'
              : value === 'skip'
                ? 'dilewati'
                : '—';
        row.append(label, badge);
        $('conditions').append(row);
      }
    $('console').textContent = revealed
      ? event.output
      : '// Output disembunyikan selama latihan';
    $('explanation').textContent = revealed
      ? event.message
      : 'Hitung pola secara manual, lalu periksa jawabanmu.';
    $('progress-text').textContent =
      `Langkah ${cursor + 1} / ${trace.events.length}`;
    $('progress').max = trace.events.length - 1;
    $('progress').value = cursor;
    $('back').disabled = cursor === 0 || !revealed;
    $('forward').disabled = cursor === trace.events.length - 1 || !revealed;
    $('end').disabled = cursor === trace.events.length - 1 || !revealed;
  }
  $('pattern').addEventListener('change', setup);
  $('n').addEventListener('change', setup);
  $('practice').addEventListener('change', setup);
  $('reset').addEventListener('click', () => {
    cursor = 0;
    render();
  });
  $('back').addEventListener('click', () => {
    if (cursor > 0) {
      cursor--;
      render();
    }
  });
  $('forward').addEventListener('click', () => {
    if (cursor < trace.events.length - 1) {
      cursor++;
      render();
    }
  });
  $('end').addEventListener('click', () => {
    cursor = trace.events.length - 1;
    render();
  });
  $('reveal').addEventListener('click', () => {
    revealed = true;
    render();
  });
  $('check-answer').addEventListener('click', () => {
    if ($('answer').value.trim() === '') {
      $('answer-result').textContent = 'Isi jawaban terlebih dahulu.';
      return;
    }
    const actual = trace.events.at(-1).output.split('*').length - 1;
    $('answer-result').textContent =
      Number($('answer').value) === actual
        ? 'Tepat! Buka solusi untuk menelusuri alasannya.'
        : 'Belum tepat. Coba hitung jumlah bintang di setiap baris.';
  });
  setup();
})();
