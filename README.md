# Tutorial 3 Game Development

## Latihan Mandiri

### Controls
- Move Left (Left Arrow)
- Move Right (Right Arrow)
- Jump (Up Arrow)
- Crouch (Down Arrow)
- Dash (C)

## Fitur yang dikerjakan
- Double Jump

Saya implementasikan double jump dengan pertama membuat variabel `max_jumps` dan `jump_count` pada script. `max_jumps` menentukan jumlah maksimum lompatan yang bisa dilakukan di udara dan `jump_count` digunakan untuk menghitung berapa kali pemain sudah lakukan aksi jump. Setiap kali tombol lompat ditekan, sistem akan mengecek apakah `jump_count` masih lebih kecil dari `max_jumps`. Jika masih memenuhi syarat nilai `velocity.y` akan diubah sesuai `jump_speed`, dan `jump_count` akan ditambah satu. Ketika karakter menyentuh lantai (`is_on_floor()`), nilai jump_count akan direset ke 0 sehingga pemain dapat kembali melakukan dua kali lompatan. Ini untuk memastikan agar player tidak melakukan aksi jump trus secara infinite.

- Dash

Saya pertama menambahkan variabel `dash_speed`, `dash_duration`, `dash_cooldown`, `is_dashing`, dan `can_dash`. Ketika pemain menekan tombol dash dan kondisi `can_dash` == true, fungsi `start_dash()` akan dipanggil. Pada fungsi tersebut, status `is_dashing` diaktifkan dan karakater melakukan sebuah *dash*. Selama dash berlangsung, pergerakan normal dan gravitasi dihentikan dengan kondisi `if is_dashing` di awal function utama. Durasi dash dihitung menggunakan variabel `dash_time_left` yang dikurangi setiap frame berdasarkan delta. Setelah dash selesai, karakter kembali ke pergerakan normal, dan sistem cooldown dijalankan menggunakan `create_timer()` sebelum `can_dash` diaktifkan kembali. Saya melakukan ini agar karakter dapat melakukan aksi dash, tetapi dengan tidak berlebihan. Also untuk tombol mapping agar ke C saya modify langsung ke project settings godot engine. 

- Crouch

Saya pertama tambahkan variabel `is_crouching` yang akan bernilai true ketika pemain menahan arrow down dan karakter sedang berada di lantai. Saya menggunakan `Input.is_action_pressed()` agar crouch tetap aktif selama tombol ditekan (hold), bukan `is_action_just_pressed()`. Saat crouch aktif, nilai `velocity.x` diatur menjadi nol sehingga karakter tidak dapat bergerak secara horizontal. Selain itu, sistem animasi akan mengganti tampilan karakter menjadi animasi crouch. Saya juga tidak mengganti collision dari character walaupun player melakukan crouch.

- Implementasi Animation and Polishing

Terakhir, saya menambahkan polishing yaitu mengganti Sprite2D menjadi AnimatedSprite2D agar karakter memiliki animasi idle, run, jump, dash, dan crouch. Saya membuat fungsi `update_animation()` untuk menentukan sprite saat melakukan suatu aksi. Selain itu, saya menambahkan `anim.flip_h` agar sprite otomatis menghadap ke arah gerakan karakter.

Reference:
- Movement and Mapping buttons (https://www.youtube.com/watch?v=RDT5hfYWCrQ) 
- AnimatedSprite2D Tutorial (https://www.youtube.com/watch?v=tfdXgiMwUBw&pp=ygUSYW5pbWF0ZWQgc3ByaXRlIDJk) 
- Tutorial GameDev 3 (https://csui-game-development.github.io/tutorials/tutorial-3/)
- GDScript Reference (https://docs.godotengine.org/en/4.3/tutorials/scripting/gdscript/gdscript_basics.html)