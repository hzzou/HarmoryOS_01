import { hilog } from '@kit.PerformanceAnalysisKit';

const LOGGER_PREFIX: string = 'News Release: ';

class Logger{
  private domain: number;
  private prefix: string;

  // 第一个字符串的格式转换符， 第二个字符串的格式转换符
  private format: string = '%{public}s, %{public}s';

  constructor(prefix: string = '', domain: number = 0xFF00) {
    this.domain = domain;
    this.prefix = prefix;
  }

  debug(...args: string[]){
    hilog.debug(this.domain, this.prefix, this.format, args);
  }

  info(...args: string[]){
    hilog.info(this.domain, this.prefix, this.format, args);
  }

  warn(...args: string[]){
    hilog.warn(this.domain, this.prefix, this.format, args);
  }

  error(...args: string[]){
    hilog.error(this.domain, this.prefix, this.format, args);
  }
}

export default new Logger(LOGGER_PREFIX);