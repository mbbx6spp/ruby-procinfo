#include <ruby.h>

#include <sys/resource.h>
#include <sys/wait.h>

static VALUE S_PROC_INFO = Qnil;

// signatures
void Init_procinfo(void);
static VALUE procinfo_stats(VALUE);
static VALUE _to_proc_stats_struct(const struct rusage *);
static VALUE _to_time_value(struct timeval);

static VALUE procinfo_stats(VALUE self) {
  struct rusage usage;
  if (getrusage(RUSAGE_SELF, &usage) == -1) {
    rb_raise(rb_eRuntimeError, "getrusage call returned -1");
  }

  return _to_proc_stats_struct(&usage);
}

static VALUE _to_proc_stats_struct(const struct rusage *usage) {
  VALUE user_time = _to_time_value(usage->ru_utime);
  VALUE system_time = _to_time_value(usage->ru_stime);
  VALUE max_rss = rb_int_new(usage->ru_maxrss);
  VALUE shared_text_size = rb_int_new(usage->ru_ixrss);
  VALUE unshared_data_size = rb_int_new(usage->ru_idrss);
  VALUE unshared_stack_size = rb_int_new(usage->ru_isrss);
  VALUE page_reclaims = rb_int_new(usage->ru_minflt);
  VALUE page_faults = rb_int_new(usage->ru_majflt);
  VALUE swaps = rb_int_new(usage->ru_nswap);
  VALUE block_input_ops = rb_int_new(usage->ru_inblock);
  VALUE block_output_ops = rb_int_new(usage->ru_oublock);
  VALUE msgs_sent = rb_int_new(usage->ru_msgsnd);
  VALUE msgs_recvd = rb_int_new(usage->ru_msgrcv);
  VALUE signals_recvd = rb_int_new(usage->ru_nsignals);
  VALUE voluntary_switches = rb_int_new(usage->ru_nvcsw);
  VALUE involuntary_switches = rb_int_new(usage->ru_nivcsw);
  return rb_struct_new(S_PROC_INFO,
    user_time,              // usage->ru_utime
    system_time,            // usage->ru_stime
    max_rss,                // usage->ru_maxrss
    shared_text_size,       // usage->ru_ixrss
    unshared_data_size,     // usage->ru_idrss
    unshared_stack_size,    // usage->ru_isrss
    page_reclaims,          // usage->ru_minflt
    page_faults,            // usage->ru_majflt
    swaps,                  // usage->ru_nswap
    block_input_ops,        // usage->ru_inblock
    block_output_ops,       // usage->ru_oublock
    msgs_sent,              // usage->ru_msgsnd
    msgs_recvd,             // usage->ru_msgrcv
    signals_recvd,          // usage->ru_nsignals
    voluntary_switches,     // usage->ru_nvcsw
    involuntary_switches,   // usage->ru_nivcsw
    NULL);
}

static VALUE _to_time_value(struct timeval t) {
  double time = t.tv_sec + t.tv_usec / 1000000.0;
  return rb_float_new(time);
}

// Initialization function to setup struct and module method
void Init_procinfo(void) {
  VALUE M_PROCESS = rb_define_module("Process");
  S_PROC_INFO = rb_struct_define("ProcStats",
                  "user_time", "system_time", "max_rss",
                  "shared_text_size", "unshared_data_size",
                  "unshared_stack_size", "page_reclaims", "page_faults",
                  "swaps", "block_input_ops", "block_output_ops",
                  "msgs_sent", "msgs_recvd", "signals_recvd",
                  "voluntary_switches", "involuntary_switches", NULL);

  rb_const_set(M_PROCESS, rb_intern("ProcStats"), S_PROC_INFO);
  rb_define_singleton_method(M_PROCESS, "stats", procinfo_stats, 0);
}
