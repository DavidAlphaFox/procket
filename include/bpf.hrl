%% Copyright (c) 2011, Michael Santos <michael.santos@gmail.com>
%% All rights reserved.
%%
%% Redistribution and use in source and binary forms, with or without
%% modification, are permitted provided that the following conditions
%% are met:
%%
%% Redistributions of source code must retain the above copyright
%% notice, this list of conditions and the following disclaimer.
%%
%% Redistributions in binary form must reproduce the above copyright
%% notice, this list of conditions and the following disclaimer in the
%% documentation and/or other materials provided with the distribution.
%%
%% Neither the name of the author nor the names of its contributors
%% may be used to endorse or promote products derived from this software
%% without specific prior written permission.
%%
%% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
%% "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
%% LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
%% FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
%% COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
%% INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
%% BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
%% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
%% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
%% LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
%% ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
%% POSSIBILITY OF SUCH DAMAGE.

%%-------------------------------------------------------------------------
%%% BPF ioctl structures and commands
%%-------------------------------------------------------------------------

-define(SIZEOF_STRUCT_IFREQ, 32).
-define(SIZEOF_INT32_T, 4).
-define(SIZEOF_U_INT, ?SIZEOF_INT32_T).

%% struct bpf_program {
%%         u_int bf_len;
%%         struct bpf_insn *bf_insns;
%% };

%% struct bpf_insn {
%%         u_short     code;
%%         u_char      jt;
%%         u_char      jf;
%%         bpf_u_int32 k;
%% };
-define(SIZEOF_STRUCT_BPF_PROGRAM,
    (2 + 1 + 1 + ?SIZEOF_U_INT)).

%% struct bpf_stat {
%%         u_int bs_recv;
%%         u_int bs_drop;
%% };
-define(SIZEOF_STRUCT_BPF_STAT,
    (?SIZEOF_U_INT + ?SIZEOF_U_INT)).

%% struct bpf_version {
%%         u_short bv_major;
%%         u_short bv_minor;
%% };
-define(SIZEOF_STRUCT_BPF_VERSION, (2 + 2)).

%% struct bpf_dltlist {
%%     u_int32_t       bfl_len;
%%     union {
%%         u_int32_t   *bflu_list;
%%         u_int64_t   bflu_pad;
%%     } bfl_u;
%% };
-define(SIZEOF_STRUCT_BPF_DLTLIST,
    (?SIZEOF_U_INT + ?SIZEOF_U_INT + 4)).

%% #define BPF_ALIGNMENT sizeof(int32_t)
-define(BPF_ALIGNMENT, ?SIZEOF_INT32_T).
%% #define BPF_WORDALIGN(x) (((x)+(BPF_ALIGNMENT-1))&~(BPF_ALIGNMENT-1))
-define(BPF_WORDALIGN(X), bpf:align(X)).

-define(IOC_IN, 16#80000000).
-define(IOC_OUT, 16#40000000).
-define(IOC_INOUT, ?IOC_IN bor ?IOC_OUT).
-define(IOC_VOID, 16#20000000).
-define(IOCPARM_MASK, 16#1fff).

-define(BIOCGBLEN, bpf:ior($B, 102, ?SIZEOF_U_INT)).
-define(BIOCSBLEN, bpf:iowr($B, 102, ?SIZEOF_U_INT)).
-define(BIOCSETF, bpf:iow($B, 103, ?SIZEOF_STRUCT_BPF_PROGRAM)).
-define(BIOCFLUSH, bpf:io($B, 104)).
-define(BIOCPROMISC, bpf:io($B, 105)).
-define(BIOCGDLT, bpf:ior($B,106, ?SIZEOF_U_INT)).
-define(BIOCGETIF, bpf:ior($B,107, ?SIZEOF_STRUCT_IFREQ)).
-define(BIOCSETIF, bpf:iow($B, 108, ?SIZEOF_STRUCT_IFREQ)).
-define(BIOCSRTIMEOUT, bpf:iow($B, 109, bpf:sizeof(timeval)).
-define(BIOCGRTIMEOUT, bpf:ior($B, 110, bpf:sizeof(timeval)).
-define(BIOCGSTATS, bpf:ior($B, 111, ?SIZEOF_STRUCT_BPF_STAT)).
-define(BIOCIMMEDIATE, bpf:iow($B, 112, ?SIZEOF_U_INT)).
-define(BIOCVERSION, bpf:ior($B, 113, ?SIZEOF_STRUCT_BPF_VERSION)).
-define(BIOCGRSIG, bpf:ior($B, 114, ?SIZEOF_U_INT)).
-define(BIOCSRSIG, bpf:iow($B, 115, ?SIZEOF_U_INT)).
-define(BIOCGHDRCMPLT, bpf:ior($B, 116, ?SIZEOF_U_INT)).
-define(BIOCSHDRCMPLT, bpf:iow($B, 117, ?SIZEOF_U_INT)).
-define(BIOCGSEESENT, bpf:ior($B, 118, ?SIZEOF_U_INT)).
-define(BIOCSSEESENT, bpf:iow($B, 119, ?SIZEOF_U_INT)).
-define(BIOCSDLT, bpf:iow($B, 120, ?SIZEOF_U_INT)).
-define(BIOCGDLTLIST, bpf:iowr($B, 121, ?SIZEOF_STRUCT_BPF_DLTLIST)).

%% Datalink types
-define(DLT_NULL, 0).
-define(DLT_EN10MB, 1).
-define(DLT_EN3MB, 2).
-define(DLT_AX25, 3).
-define(DLT_PRONET, 4).
-define(DLT_CHAOS, 5).
-define(DLT_IEEE802, 6).
-define(DLT_ARCNET, 7).
-define(DLT_SLIP, 8).
-define(DLT_PPP, 9).
-define(DLT_FDDI, 10).
-define(DLT_ATM_RFC1483, 11).
-define(DLT_RAW, 12).
-define(DLT_SLIP_BSDOS, 15).
-define(DLT_PPP_BSDOS, 16).
-define(DLT_PFSYNC, 18).
-define(DLT_ATM_CLIP, 19).
-define(DLT_PPP_SERIAL, 50).
-define(DLT_C_HDLC, 104).
-define(DLT_CHDLC, ?DLT_C_HDLC).
-define(DLT_IEEE802_11, 105).
-define(DLT_LOOP, 108).
-define(DLT_LINUX_SLL, 113).
-define(DLT_PFLOG, 117).
-define(DLT_IEEE802_11_RADIO, 127).
-define(DLT_APPLE_IP_OVER_IEEE1394, 138).
-define(DLT_IEEE802_11_RADIO_AVS, 163).


%%-------------------------------------------------------------------------
%%% BPF Filter
%%-------------------------------------------------------------------------

%% instruction classes
-define(BPF_CLASS(Code), (Code band 16#07)).
-define(BPF_LD, 16#00).
-define(BPF_LDX, 16#01).
-define(BPF_ST, 16#02).
-define(BPF_STX, 16#03).
-define(BPF_ALU, 16#04).
-define(BPF_JMP, 16#05).
-define(BPF_RET, 16#06).
-define(BPF_MISC, 16#07).

%% ld/ldx fields
-define(BPF_SIZE(Code), (Code band 16#18)).
-define(BPF_W, 16#00).
-define(BPF_H, 16#08).
-define(BPF_B, 16#10).
-define(BPF_MODE(Code), (Code band 16#e0)).
-define(BPF_IMM, 16#00).
-define(BPF_ABS, 16#20).
-define(BPF_IND, 16#40).
-define(BPF_MEM, 16#60).
-define(BPF_LEN, 16#80).
-define(BPF_MSH, 16#a0).

%% alu/jmp fields
-define(BPF_OP(Code), (Code band 16#f0)).
-define(BPF_ADD, 16#00).
-define(BPF_SUB, 16#10).
-define(BPF_MUL, 16#20).
-define(BPF_DIV, 16#30).
-define(BPF_OR, 16#40).
-define(BPF_AND, 16#50).
-define(BPF_LSH, 16#60).
-define(BPF_RSH, 16#70).
-define(BPF_NEG, 16#80).
-define(BPF_JA, 16#00).
-define(BPF_JEQ, 16#10).
-define(BPF_JGT, 16#20).
-define(BPF_JGE, 16#30).
-define(BPF_JSET, 16#40).
-define(BPF_SRC(Code), (Code band 16#08)).
-define(BPF_K, 16#00).
-define(BPF_X, 16#08).

%% ret - BPF_K and BPF_X also apply
-define(BPF_RVAL(Code), (Code band 16#18)).
-define(BPF_A, 16#10).

%% misc
-define(BPF_MISCOP(Code), (Code band 16#f8)).
-define(BPF_TAX, 16#00).
-define(BPF_TXA, 16#80).

%% struct bpf_insn {
%%     u_short code;
%%     u_char  jt;
%%     u_char  jf;
%%     bpf_u_int32 k;
%% };
%% NOTE: the man page says k is a u_long,
%% the header says u_int32_t.
-record(insn, {
        code = 0,
        jt = 0,
        jf = 0,
        k = 0
    }).

-define(BPF_STMT(Code, K), bpf:stmt(Code, K)).
-define(BPF_JUMP(Code, K, JT, JF), bpf:jump(Code, K, JT, JF)).
