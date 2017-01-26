module main;

import io = watt.io;
import amp.sdl2;


fn main() i32
{
	win := SDL_CreateWindow("SDL Test".ptr,
		SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
		800, 600, cast(u32)(SDL_WINDOW_RESIZABLE));
	looping := true;

	while (looping) {
		SDL_Event e;

		// Block until next event.
		if (SDL_WaitEvent(&e) != 1) {
			io.writefln("Error");
			looping = false;
			break;
		}

		// Dispatch that event and then drain all other events.
		do {
			handleEvent(ref e, ref looping);
		} while (SDL_PollEvent(&e));
	}

	io.writefln("exiting");
	return 0;
}

fn handleEvent(ref e: SDL_Event, ref looping: bool)
{
	switch (e.type) {
	case SDL_MOUSEMOTION:
		break;
	case SDL_TEXTINPUT:
		i: size_t;
		for (; i < e.text.text.length && e.text.text[i]; i++) {}
		io.writefln("SDL_TEXTINPUT \"%s\"", e.text.text[0 .. i]);
		break;
	case SDL_KEYUP:
		io.writefln("SDL_KEYUP %s", e.key.keysym.sym);
		break;
	case SDL_KEYDOWN:
		io.writefln("SDL_KEYDOWN %s", e.key.keysym.sym);
		break;
	case SDL_WINDOWEVENT:
		io.writefln("SDL_WINDOWEVENT %s", e.window.event);
		break;
	case SDL_QUIT:
		io.writefln("SDL_QUIT");
		looping = false;
		break;
	default:
		io.writefln("SDL_??? %s", e.type);
	}
}
