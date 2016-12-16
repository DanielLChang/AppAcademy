class Clock {
  constructor() {
      // 1. Create a Date object.
      // 2. Store the hours, minutes, and seconds.
      // 3. Call printTime.
      // 4. Schedule the tick at 1 second intervals.
      const time = new Date();
      this.seconds = time.getSeconds();
      this.minutes = time.getMinutes();
      this.hours = time.getHours();
      this.printTime();
      setInterval(this._tick.bind(this), 1000);
    }

    printTime() {
      // Format the time in HH:MM:SS
      // Use console.log to print it.
      const sec = (this.seconds < 10) ? `0${this.seconds}` : `${this.seconds}`;
      const min = (this.minutes < 10) ? `0${this.minutes}` : `${this.minutes}`;
      const hrs = (this.hours < 10) ? `0${this.hours}` : `${this.hours}`;

      console.log(`${hrs}:${min}:${sec}`);
    }

    _tick() {
      // 1. Increment the time by one second.
      // 2. Call printTime.
      this.seconds++;
      if (this.seconds === 60) {
        this.minutes++;
        this.seconds = 0;
      }
      if (this.minutes === 60) {
        this.hours++;
        this.minutes = 0;
      }
      if (this.hours === 24) {
        this.hours = 0;
      }
      this.printTime();
    }
  }

  const clock = new Clock();
